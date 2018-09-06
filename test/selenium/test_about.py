# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

from pages.webview.home import Home

from tests import markers


@markers.webview
@markers.test_case('C176246')
@markers.nondestructive
def test_about_us_links_are_positioned_properly(webview_base_url, selenium):
    # GIVEN the home page
    home = Home(selenium, webview_base_url).open()

    # WHEN the About Us link in the navbar is clicked
    about_us = home.header.click_about_us()

    # THEN the about us and contact links are same size
    # and vertically stacked on the left of the page
    about_us_link = about_us.about_us_link
    contact_link = about_us.contact_link
    # Same size
    assert about_us_link.size == contact_link.size
    # Stacked:
    # Same x
    assert about_us_link.location['x'] == contact_link.location['x']
    # Similar y
    assert (about_us_link.location['y'] + about_us_link.size['height'] <
            contact_link.location['y'] <
            about_us_link.location['y'] + 2 * about_us_link.size['height'])
    # On the left
    assert (about_us_link.location['x'] + about_us_link.size['width'] <
            selenium.get_window_size()['width']/2)


@markers.webview
@markers.test_case('C176247')
@markers.nondestructive
def test_about_us_content_includes_openstax_goals(webview_base_url, selenium):
    # GIVEN the home page
    home = Home(selenium, webview_base_url).open()

    # WHEN the About Us link in the navbar is clicked
    about_us = home.header.click_about_us()

    # THEN the content includes a paragraph about the goals of OpenStax
    assert ('Today, OpenStax CNX is a dynamic non-profit digital ecosystem serving '
            'millions of users per month in the delivery of educational content '
            'to improve learning outcomes.') in about_us.about_content.text


@markers.webview
@markers.test_case('C176248')
@markers.nondestructive
def test_about_us_content_links(webview_base_url, selenium):
    # GIVEN the home page
    home = Home(selenium, webview_base_url).open()

    # WHEN the About Us link in the navbar is clicked
    about_us = home.header.click_about_us()

    # THEN the content includes learn more links with the correct text
    assert about_us.about_content.learn_more_team_text == 'Learn more about the OpenStax team'
    assert (about_us.about_content.learn_more_foundations_text ==
            'Learn more about the foundations supporting OpenStax projects like CNX')
