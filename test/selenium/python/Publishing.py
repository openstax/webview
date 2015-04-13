import unittest
from selenium import webdriver
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions
from selenium.webdriver.common.by import By
import datetime

class Publishing(unittest.TestCase):
    '''
    This test...
      * Creates a Page called "Selenium Test Page" plus the date and time
      * adds a note and quotation to the Page
      * publishes the page

    '''


    def setUp(self):
        self.driver = webdriver.Firefox()
        # chrome driver option
        #self.driver = webdriver.Chrome('/home/ew2/PycharmProjects/chromedriver')
        propfile = open('properties.ini')
        items = [line.rstrip('\n') for line in propfile]
        self.authkey = items[0]
        self.pw = items[1]
        self.url = items[2]

    def tearDown(self):
        self.driver.save_screenshot('publishing-test.png')
        self.driver.quit()

    def test_publishing(self):
        self.driver.get(self.url)
        self.driver.implicitly_wait(300)
        # login
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
        listItem = self.driver.find_element_by_css_selector('li.menuitem.new-page')
        listItem.click()
        #add title to modal
        modal = self.driver.find_element_by_id('new-media-modal')
        titlefield = modal.find_element_by_name('title')
        titlefield.send_keys('Selenium Test Page ' + str(datetime.datetime.now()))
        createbutton = self.driver.find_element_by_xpath("//button[@type='submit']")
        createbutton.click()
        self.driver.implicitly_wait(300)
        # add quotation
        quote_element = self.driver.find_element_by_css_selector('blockquote.quote.ui-draggable')
        dest_element = self.driver.find_element_by_xpath('/html/body/section/div/div[2]/div[2]/div[1]/div[7]')
        ActionChains(self.driver).drag_and_drop(quote_element, dest_element).perform()
        self.driver.implicitly_wait(300)
        dest_element.click()
        dest_element.click()
        # add note
        source_element = self.driver.find_element_by_css_selector('div.note.ui-draggable')
        ActionChains(self.driver).drag_and_drop(source_element, dest_element).perform()
        # clicking and waiting to force editor to refresh after drop
        self.driver.implicitly_wait(300)
        dest_element.click()
        dest_element.click()
        self.driver.implicitly_wait(300)
        dest_element.click()
        dest_element.click()
        # save Page
        savebutton = self.driver.find_element_by_xpath('(//button[@type="button"])[23]')
        savebutton.click()
        self.driver.implicitly_wait(2000)
        # click publish button
        publishbutton = self.driver.find_element_by_css_selector('html body section#main div div#contents div div.editbar div nav.navbar.navbar-default.navbar-fixed-top div.container-fluid div#editbar-navbar-collapse.navbar-collapse.collapse.toolbar div.navbar-right button.publish.btn.btn-primary.navbar-btn')
        publishbutton.click()
        self.driver.implicitly_wait(300)
        # fill out publish popup
        licensecheckbox = self.driver.find_element_by_name('license')
        licensecheckbox.click()
        description = self.driver.find_element_by_name('submitlog')
        description.send_keys('Publishing test')
        wait = WebDriverWait(self.driver, 10)
        # publish
        publish = wait.until(expected_conditions.element_to_be_clickable((By.XPATH,'(//button[@type="submit"])[5]')))
        publish.click()

        # verify in workspace



if __name__ == "__main__":
    unittest.main()

