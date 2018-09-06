# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

from tests import markers

from pages.webview.home import Home
from pages.webview.donate import Donate
from pages.webview.donate_form import DonateForm


@markers.webview
@markers.test_case('C176262')
@markers.nondestructive
def test_donate_form_loads(webview_base_url, selenium):
    # GIVEN the home page
    home = Home(selenium, webview_base_url).open()

    # WHEN the donate link is clicked and then the donate now button is clicked
    donate = home.header.click_donate()
    donate_form = donate.submit()

    # THEN the donate form is displayed with the correct url
    assert type(donate_form) is DonateForm
    assert donate_form.is_form_displayed
    assert donate_form.amount == 10


@markers.webview
@markers.test_case('C176266', 'C176267')
@markers.nondestructive
def test_donate_form_incomplete(webview_base_url, selenium):
    # GIVEN the donation form
    home = Home(selenium, webview_base_url).open()
    donate = home.header.click_donate()
    donate_form = donate.submit()

    # WHEN the form is submitted without all the required fields being filled
    donate_form = donate_form.submit()

    # THEN the donate form is still displayed
    assert type(donate_form) is DonateForm
    assert donate_form.is_form_displayed
    assert donate_form.amount == 10
    # We cannot test for the error message, since it's handled completely by the browser
    # due to the HTML5 "required" attribute
    # Instead, we check that there are required inputs in the page
    assert len(donate_form.required_inputs) > 0


@markers.webview
@markers.test_case('C176264')
@markers.nondestructive
def test_donate_slider(webview_base_url, selenium):
    # GIVEN the home page
    home = Home(selenium, webview_base_url).open()

    # WHEN the donate link is clicked and then the donate now button is clicked
    donate = home.header.click_donate()
    donation_slider = donate.donation_slider

    # THEN the donation slider can be dragged around and correct donation values are displayed
    assert type(donate) is Donate
    donation_values = [5, 10, 15, 20, 25, 50, 75, 100, 250, 500, 1000, 2500, 5000, 10000]
    starting_index = 1
    assert donation_slider.range_input_value == donation_slider.donation_value
    assert donation_slider.donation_value == donation_values[starting_index]

    for i in range(starting_index):
        donation_slider.move_left()
        assert donation_slider.range_input_value == donation_slider.donation_value
        assert donation_slider.donation_value == donation_values[starting_index - i - 1]

    for donation_value in donation_values[1:]:
        donation_slider.move_right()
        assert donation_slider.range_input_value == donation_slider.donation_value
        assert donation_slider.donation_value == donation_value
