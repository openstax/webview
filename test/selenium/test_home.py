# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

import random
from urllib.parse import urljoin
from datetime import datetime

from tests import markers

from pages.webview.home import Home
from tests.utils import similar

_number_of_tested_books = 2


@markers.webview
@markers.test_case('C167405')
@markers.nondestructive
@markers.parametrize('width,height', [(1024, 768), (640, 480), (480, 640)])
def test_top_right_links_and_nav(width, height, webview_base_url, legacy_base_url, selenium):
    # GIVEN the webview URL, the legacy URL, and the Selenium driver with the window size set

    # WHEN the webview home page is fully loaded
    home = Home(selenium, webview_base_url).open()
    header = home.header

    # THEN the top right links, logos and nav are displayed and point to the correct URLs
    assert header.is_support_link_displayed
    assert header.support_url == 'https://openstax.secure.force.com/help'

    assert header.is_legacy_site_link_displayed
    expected_legacy_url = urljoin(legacy_base_url, '/content?legacy=true')
    assert header.legacy_site_url == expected_legacy_url, (
               'The legacy URL in the CNX home page did not match the legacy_base_url. '
               'Check that both webview_base_url and legacy_base_url point to the same environment.'
           )

    assert header.is_cnx_logo_displayed
    assert header.cnx_logo_url.rstrip('/') == webview_base_url

    assert header.is_nav_displayed

    if header.is_nav_button_displayed:
        assert not header.is_browse_link_displayed
        assert not header.is_about_us_link_displayed
        assert not header.is_donate_link_displayed
        assert not header.is_rice_logo_displayed
        header.click_nav_button()

    assert header.is_browse_link_displayed
    assert header.browse_url == urljoin(webview_base_url, '/browse')

    assert header.is_about_us_link_displayed
    assert header.about_us_url == urljoin(webview_base_url, '/about')

    assert header.is_donate_link_displayed
    assert header.donate_url == urljoin(webview_base_url, '/donate')

    assert header.is_rice_logo_displayed
    assert header.rice_logo_url.rstrip('/') == 'http://www.rice.edu'


@markers.webview
@markers.nondestructive
def test_splash_banner_loads(webview_base_url, selenium):
    # GIVEN the main website URL and the Selenium driver

    # WHEN The home page URL is fully loaded
    page = Home(selenium, webview_base_url).open()

    # THEN The splash text is correct
    assert 'Discover learning materials in an Open Space' in page.splash


@markers.webview
@markers.test_case('C176224', 'C176225')
@markers.nondestructive
def test_featured_books_load(webview_base_url, selenium):
    # GIVEN the webview base url and the Selenium driver

    # WHEN the home page is fully loaded
    page = Home(selenium, webview_base_url).open()

    # THEN there are featured books for both OpenStax and CNX
    assert len(page.featured_books.openstax_list) > 0
    assert len(page.featured_books.cnx_list) > 0


@markers.webview
@markers.test_case('C176226')
@markers.nondestructive
def test_featured_books_have_title_and_intro(webview_base_url, selenium):
    # GIVEN the webview base url and the Selenium driver

    # WHEN the home page is fully loaded
    home = Home(selenium, webview_base_url).open()

    # THEN all OpenStax books have titles and intros and all CNX books have titles
    # Book intros must not contain `...`. They may contain `…` but can't contain ONLY `…`.
    for book in home.featured_books.openstax_list:
        assert book.title
        intro = book.intro
        assert intro
        assert '...' not in intro
        assert intro != '…'

    # 2 CNX books have no intros and that is a WON'T FIX
    # because it would require us to contact the authors
    num_no_intro_cnx_books = 0
    for book in home.featured_books.cnx_list:
        assert book.title
        intro = book.intro
        if not intro:
            num_no_intro_cnx_books += 1
        assert '...' not in intro
        assert intro != '…'
    assert num_no_intro_cnx_books == 2


@markers.webview
@markers.test_case('C176227')
@markers.nondestructive
def test_show_more_and_less_expands_or_contracts_book_intro(webview_base_url, selenium):
    # GIVEN the webview base url and the Selenium driver

    # WHEN the home page is fully loaded,
    #      find the first OpenStax book and click Show More
    home = Home(selenium, webview_base_url).open()
    books = home.featured_books.openstax_list
    books_with_show_more = [book for book in books if book.is_show_more_displayed]
    assert len(books_with_show_more) >= _number_of_tested_books
    for book in random.sample(books_with_show_more, _number_of_tested_books):
        short_intro = book.intro
        assert book.is_intro_collapsed
        book = book.click_show_more()

        # THEN The book description is expanded and can be collapsed again
        long_intro = book.intro
        assert '…' not in long_intro
        assert book.is_show_less_displayed
        assert long_intro.startswith(short_intro.rstrip('…'))

        book = book.click_show_less()
        assert book.intro == short_intro
        assert book.is_show_more_displayed


@markers.webview
@markers.test_case('C176228')
@markers.nondestructive
def test_book_cover_loads_correct_page(webview_base_url, selenium):
    # GIVEN the webview base url, the Selenium driver, and a similarity ratio
    sim_ratio = .4

    # WHEN the home page is fully loaded,
    # AND we have a random OpenStax book title
    # AND we click the book cover link and load a content page
    # AND we have the title from the content page
    # AND we have a similarity ratio of the title

    home = Home(selenium, webview_base_url).open()
    book = home.featured_books.get_random_openstax_book()

    book_title = book.clean_title
    content = book.click_book_cover()
    content_title = content.clean_title

    title_ratio = similar(book_title, content_title)

    # THEN compare the title from the home page and the content page for exact-ness.
    assert book_title == content_title or title_ratio >= sim_ratio


@markers.webview
@markers.test_case('C176229')
@markers.nondestructive
def test_title_link_loads_correct_page(webview_base_url, selenium):
    # GIVEN the webview base url, the Selenium driver, and a similarity ratio
    sim_ratio = .4

    # WHEN the home page is fully loaded,
    # AND we have a random OpenStax book title
    # AND we click the title link and load a content page
    # AND we have the title from the content page
    # AND we have a similarity ratio of the title

    home = Home(selenium, webview_base_url).open()
    book = home.featured_books.get_random_openstax_book()

    book_title = book.clean_title
    content = book.click_title_link()
    content_title = content.clean_title

    title_ratio = similar(book_title, content_title)

    # THEN compare the title from the home page and the content page for exact-ness.
    assert book_title == content_title or title_ratio >= sim_ratio


@markers.webview
@markers.test_case('C176230')
@markers.nondestructive
def test_logo_link_stays_on_home_page(webview_base_url, selenium):
    # GIVEN the home page
    home = Home(selenium, webview_base_url).open()

    # WHEN the OpenStax CNX logo is clicked
    home = home.header.click_cnx_logo()

    # THEN we are still in the home page
    assert type(home) is Home


@markers.webview
@markers.test_case('C167406')
@markers.nondestructive
def test_footer_has_correct_content_and_links(webview_base_url, selenium):
    # GIVEN the home page
    home = Home(selenium, webview_base_url).open()

    # WHEN we scroll to the footer
    footer = home.footer
    footer.scroll_to()

    # THEN the links point to the correct urls and all the content is displayed
    assert footer.is_licensing_link_displayed
    assert footer.licensing_url == urljoin(webview_base_url, '/license')

    assert footer.is_terms_of_use_link_displayed
    assert footer.terms_of_use_url == urljoin(webview_base_url, '/tos')

    assert footer.is_accessibility_statement_link_displayed
    assert footer.accessibility_statement_url == 'https://openstax.org/accessibility-statement'

    assert footer.is_contact_link_displayed
    assert footer.contact_url == urljoin(webview_base_url, '/about/contact')

    assert footer.is_foundation_support_paragraph_displayed
    assert footer.foundation_support_text == (
        'Supported by William & Flora Hewlett Foundation, Bill & Melinda Gates Foundation,'
        ' Michelson 20MM Foundation, Maxfield Foundation, Open Society Foundations, and'
        ' Rice University. Powered by OpenStax CNX.')

    assert footer.is_ap_paragraph_displayed
    assert footer.ap_text == (
        'Advanced Placement® and AP® are trademarks registered and/or owned by the College Board,'
        ' which was not involved in the production of, and does not endorse, this site.')

    assert footer.is_copyright_statement_paragraph_displayed
    year = datetime.now().year
    assert footer.copyright_statement_text == (
        '© 1999-{year}, Rice University. Except where otherwise noted, content created on this site'
        ' is licensed under a Creative Commons Attribution 4.0 License.'.format(year=year))

    assert footer.is_android_app_link_displayed
    assert footer.android_app_url == (
        'https://play.google.com/store/apps/details?id=org.openstaxcollege.android')

    webview_url = urljoin(webview_base_url, '/')

    assert footer.is_facebook_link_displayed
    assert footer.facebook_url == (
        'https://facebook.com/sharer/sharer.php?u={webview_url}'.format(webview_url=webview_url))

    assert footer.is_twitter_link_displayed
    assert footer.twitter_url == ('https://twitter.com/share?url={webview_url}&text=An%20OpenStax'
                                  '%20CNX%20book&via=cnxorg'.format(webview_url=webview_url))

    assert footer.is_email_link_displayed
    assert footer.email_url == 'mailto:support@openstax.org'

    footer_text = footer.text
    assert 'Dev Blog' not in footer_text
    assert 'iTunes U' not in footer_text
    assert 'Google Plus' not in footer_text
