import unittest
from selenium import webdriver

class ViewRecentlyPublished(unittest.TestCase):
    '''
    This test logs in a user and creates a Book in the user's workspace
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

    def test_recently_published(self):
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
        #click on Recently published button
        recentbutton = self.driver.find_element_by_link_text('Recently published')
        recentbutton.click()
        #find link to click
        link = self.driver.find_element_by_link_text('Image Test')
        link.click()
        #verify text
        heading = self.driver.find_element_by_css_selector('div.media-header > div.title > h2')
        self.assertEquals(heading.text,'Image Test')

if __name__ == "__main__":
    unittest.main()