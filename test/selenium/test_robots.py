# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

from tests import markers

from pages.robots import Robots


@markers.webview
@markers.test_case('C181347', 'C193737')
@markers.nondestructive
def test_robots(webview_base_url, archive_base_url, selenium):
    # GIVEN the webview base url, the archive base url and the Selenium driver

    # WHEN we visit /robots.txt in webview and archive
    webview_robots = Robots(selenium, webview_base_url).open()
    # Add leading and trailing newlines to facilitate matching
    webview_robots_text = '\n{text}\n'.format(text=webview_robots.text)

    archive_robots = Robots(selenium, archive_base_url).open()
    archive_robots_text = '\n{text}\n'.format(text=archive_robots.text)

    # THEN robots.txt has the correct content
    assert '\nUser-agent: *\nDisallow: /\n' in webview_robots_text

    # The following directives are only present on staging:
    if 'staging.cnx.org' in webview_base_url:
        assert '\nUser-agent: ScoutJet\nCrawl-delay: 10\nDisallow: /\n' in webview_robots_text
        assert '\nUser-agent: Baiduspider\nCrawl-delay: 10\nDisallow: /\n' in webview_robots_text
        assert '\nUser-agent: BecomeBot\nCrawl-delay: 20\nDisallow: /\n' in webview_robots_text
        assert '\nUser-agent: Slurp\nCrawl-delay: 10\nDisallow: /\n' in webview_robots_text

    assert '\nUser-agent: *\nDisallow: /\n' in archive_robots_text
