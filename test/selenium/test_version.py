# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

from datetime import datetime
from warnings import warn

from tests import markers
from tests.utils import shorten_tag

from pages.webview.version import Version
from pages.webview.history import History


@markers.webview
@markers.test_case('C175150')
@markers.nondestructive
def test_version(webview_base_url, selenium, github, record_property):
    # GIVEN the webview base url, the Selenium driver, the GitHub API client and the current time
    now = datetime.utcnow()

    # WHEN the version and history pages have been visited
    version = Version(selenium, webview_base_url).open()
    version_parser = version.version_parser

    history = History(selenium, webview_base_url).open()
    history_url = selenium.current_url
    release_parsers = history.release_parsers

    # THEN - the release is less than 2 days old (warning only)
    #      - the tags for webview, archive and deploy are the latest tags (warning only)
    #      - the last 2 releases in history.txt are not exactly identical (warning only)
    #      - version.txt matches the JSON for the latest release in history.txt
    current_release_parser = release_parsers[0]
    current_version_parser = current_release_parser.version_parser

    release_date = current_version_parser.date
    release_timedelta = now - current_version_parser.datetime
    release_days = release_timedelta.days
    if release_days >= 2:
        warn('\n\nThe latest release in {history_url}'
             ' ({release_date}) is {release_days} days old.'.format(
                 history_url=history_url,
                 release_date=release_date,
                 release_days=release_days
             ))

    tag_tests = [('webview', 'webview_tag'),
                 ('cnx-archive', 'cnx_archive'),
                 ('cnx-deploy', 'cnx_deploy')]
    for (repository_name, tag_property) in tag_tests:
        current_tag_name = shorten_tag(getattr(current_version_parser, tag_property))
        repository = github.repository('Connexions', repository_name)
        repository_url = repository.git_url
        latest_tag = list(repository.tags(number=1))[0]
        latest_tag_name = latest_tag.name
        if current_tag_name != latest_tag_name and current_tag_name != latest_tag.commit.sha:
            warn('\n\nThe {repository_name} tag for the latest release in {url} ({current_tag})'
                 ' does not match the latest tag in {repository_url} ({latest_tag})'.format(
                     repository_name=repository_name,
                     url=history_url,
                     current_tag=current_tag_name,
                     repository_url=repository_url,
                     latest_tag=latest_tag_name
                 ))

    for index in range(len(release_parsers) - 1):
        releases_ago = index + 1
        previous_release_parser = release_parsers[releases_ago]
        if not current_release_parser.has_same_versions_as(previous_release_parser):
            break
        elif releases_ago == 1:
            previous_release_date = previous_release_parser.version_parser.date
            warn('\n\nAll versions in the previous release ({previous_release_date}) match'
                 ' the current release exactly. Release diff based on older release.\n'.format(
                     previous_release_date=previous_release_date
                 ))

    if releases_ago == 1:
        releases_ago_string = 'the previous release'
    else:
        releases_ago_string = '{releases_ago} releases ago'.format(releases_ago=releases_ago)
    record_property(
        'terminal_summary_message',
        '\nRelease diff from {releases_ago_string} to the current release:\n\n{diff}'.format(
            releases_ago_string=releases_ago_string,
            diff=current_release_parser.diff(previous_release_parser)))

    assert version_parser.dict == current_version_parser.dict
