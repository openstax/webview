import unittest
from selenium import webdriver
from selenium.webdriver.common.keys import Keys

class EditPage(unittest.TestCase):
    '''
    This test does not work yet.

    '''


    def setUp(self):
        self.driver = webdriver.Firefox()
        propfile = open('properties.ini')
        items = [line.rstrip('\n') for line in propfile]
        self.authkey = items[0]
        self.pw = items[1]
        self.url = items[2]

    def tearDown(self):
        self.driver.quit()

    def test_page_editing(self):
        self.driver.get(self.url)
        self.driver.implicitly_wait(300)
        #login
        authKey = self.driver.find_element_by_name('auth_key')
        authKey.send_keys(self.authkey)
        pw = self.driver.find_element_by_name('password')
        pw.send_keys(self.pw)
        signin = self.driver.find_element_by_css_selector('button.standard')
        signin.click()
        self.driver.implicitly_wait(300)
        #open page
        pagelink = self.driver.find_element_by_link_text('Selenium Test Page')
        pagelink.click()
        self.driver.implicitly_wait(300)
        editor = self.driver.find_element_by_css_selector('media-body.draft.aloha-root-editable.aloha-editable.aloha-block-blocklevel-sortable.ui-sortable.aloha-block-dropzone')
        editor.send_keys('This is a test of editing using selenium.')
        editor.send_keys(Keys.ENTER)
        #add title to modal
        #modal = self.driver.find_element_by_id('new-media-modal')
        #titlefield = modal.find_element_by_name('title')
        #titlefield.send_keys('Selenium Test Book')
        #createbutton = self.driver.find_element_by_xpath("//button[@type='submit']")
        #createbutton.click()

if __name__ == "__main__":
    unittest.main()

