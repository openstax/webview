# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

from tests import markers

from pages.webview.sitemap_index import SitemapIndex


@markers.webview
@markers.test_case('C205363')
@markers.parametrize('author_username,author_name', [('Beatrice_Riviere', 'Beatrice Riviere'),
                                                     ('richb', 'Richard Baraniuk')])
@markers.nondestructive
def test_sitemap_is_segmented_by_author(webview_base_url, selenium, author_username, author_name):
    # GIVEN the webview base url, the Selenium driver,
    #       the sitemap index, and an author's username and name
    sitemap_index = SitemapIndex(selenium, webview_base_url).open()

    # WHEN we visit the author's sitemap
    sitemap_region = sitemap_index.find_sitemap_region(author_username)
    sitemap = sitemap_region.open()

    # THEN all the content in that sitemap is by that author
    # To make this test not take forever (and because we were having trouble
    # getting some of the modules to even load), we only test one of the modules
    url_region = sitemap.url_regions[0]
    content = url_region.open()
    assert author_name in content.content_header.authors
