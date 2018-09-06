# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

from tests import markers

from pages.webview.content_status import ContentStatus


@markers.webview
@markers.test_case('C175149')
@markers.nondestructive
def test_content_status_styles(webview_base_url, selenium):
    # GIVEN the webview base url, the selenium driver, and the expected icons and colors
    gray = 'rgba(128, 128, 128, 1)'
    yellow = 'rgba(255, 165, 0, 1)'
    red = 'rgba(255, 0, 0, 1)'
    green = 'rgba(0, 128, 0, 1)'
    expected_icons_dict = {
        'queued': {'icon': 'fa-hourglass-1', 'color': gray},
        'started': {'icon': 'fa-hourglass-2', 'color': yellow},
        'retry': {'icon': 'fa-repeat', 'color': gray},
        'failure': {'icon': 'fa-close', 'color': red},
        'success': {'icon': 'fa-check-square', 'color': green},
        'fallback': {'icon': 'fa-check-square', 'color': yellow}
    }
    expected_border_style = 'solid'
    expected_border_width = '1px'
    expected_border_color = 'rgb(0, 0, 0)'

    # WHEN we load the ContentStatus page
    content_status = ContentStatus(selenium, webview_base_url).open()

    # THEN the icons are displayed and have the correct color
    #      the table is displayed and its cells have the correct border
    assert content_status.are_status_filters_displayed
    for status_filter in content_status.status_filters:
        assert status_filter.is_checkbox_displayed
        assert status_filter.is_icon_displayed

        expected = expected_icons_dict[status_filter.status]
        assert expected['icon'] in status_filter.icon_class
        assert status_filter.icon_color == expected['color']

    assert content_status.are_tds_displayed
    for td in content_status.tds:
        assert td.border_style == expected_border_style
        assert td.border_width == expected_border_width
        assert td.border_color == expected_border_color
