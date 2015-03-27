##Selenium Tests

These are automated functional tests for Webview. The tests are organized in suites which cover specific parts of the cnx.org site.  Each Suite has it's own directory.

### Running Tests

#### Install Selenium IDE

The Selenium IDE is a Firefox Add-on.

1. [Download][http://docs.seleniumhq.org/download/] the IDE. Scroll down to the IDE section to get the latest version
2. Install the XPI file into Firefox.
  * Select Tools..Add-ons from the Firefox menu
  * Click the Wrench icon and select "Install Add-on from File..."
  * Navigate to the downloaded .xpi file and install

#### Running Tests 

To run a Test Suite
1. Open Firefox
2. Open the Selenium IDE
3. Select File..Open... from the Selenium IDE menu
4. Select the <name>Suite in the file selection dialog
5. The Suite file will load all of the test cases into the IDE
6. Click on the "Play entir test suite" button in the IDE

To run a Test Case
1. If you have the Test Case open in as part of a Suite, double click the Test Case and click the "Run current Test Case" button
2. Otherwise, select File..Open... from the Selenium IDE menu
3. Select the Test Case in the file selection dialog
4. Click the "Run current Test Case" button


License
-------

This software is subject to the provisions of the GNU Affero General Public License Version 3.0 (AGPL). See license.txt for details. Copyright (c) 2015 Rice University.
