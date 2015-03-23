import unittest
from selenium import webdriver

class DeleteBook(unittest.TestCase):
    '''
    This test creates a book, clicks the back button, deletes the book and verifies the deletion
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

    def test_book_deletion(self):
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
        #add page
        addbutton = self.driver.find_element_by_xpath("(//button[@type='button'])[3]")
        addbutton.click()
        listItem = self.driver.find_element_by_css_selector('li.menuitem.new-book')
        listItem.click()
        #add title to modal
        modal = self.driver.find_element_by_id('new-media-modal')
        titlefield = modal.find_element_by_name('title')
        titlefield.send_keys('Selenium Test Book')
        createbutton = self.driver.find_element_by_xpath("//button[@type='submit']")
        createbutton.click()
        #click back button

        #delete Book

        #verify deletion

if __name__ == "__main__":
    unittest.main()

