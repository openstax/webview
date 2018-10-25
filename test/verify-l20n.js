const http = require('http')
const finalhandler = require('finalhandler')
const serveStatic = require('serve-static')

const path = require('path')
const webdriver = require('selenium-webdriver')
const Chrome = require('selenium-webdriver/chrome')
const Firefox = require('selenium-webdriver/firefox')
const until = webdriver.until


const port = process.env['PORT'] || 8080


// Start up a little webserver
const serve = serveStatic(path.join(__dirname, '../dist/'))
const server = http.createServer((req, res) => {
  const done = finalhandler(req, res)
  serve(req, res, done)
})
server.listen(port, (err) => {
  console.log('Listening on port ' + port)

  function OK() {
    process.exit(0)
  }

  function ERROR(err) {
    console.error(err)
    process.exit(1)
  }

  /*
    --headless mode does not seem to obey the `intl.accept_languages` preference
    so we perform an ugly hack to force l20n to load the Polish
    by changing the <meta> attributes to be:
    <meta name="defaultLanguage" content="pl">
    <meta name="availableLanguages" content="pl">
  */
  const chromeOptions = new Chrome.Options()
  chromeOptions.addArguments(['--headless'])
  // chromeOptions.setUserPreferences({'intl.accept_languages': 'pl'})


  const driver = new webdriver.Builder()
      .forBrowser('chrome')
      .setChromeOptions(chromeOptions)
      .build()


  driver.get('http://localhost:' + port)
  // This needs to happen before l20n begins loading
  driver.executeScript(() => {
    document.querySelector('meta[name="defaultLanguage"]').setAttribute('content', 'pl')
    document.querySelector('meta[name="availableLanguages"]').setAttribute('content', 'pl')
  })

  driver.wait(until.titleIs('Propagując wiedzę tworzymy społeczeństwo - OpenStax CNX'), 5000)
  .then(() => {
    console.log('Polish is loaded!')
    driver.quit()
    .then(OK)
    .catch(ERROR)
  })
  .catch((err) => {
    driver.quit()
    .then(() => ERROR(err))
    .catch(ERROR)
  })

})
