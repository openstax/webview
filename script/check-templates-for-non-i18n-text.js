const fs = require('fs')
const glob = require('glob')
const jsdom = require('jsdom')
const jquery = require('jquery')


glob('./src/**/*.html', (err, filenames) => {

  // fill up all the keys and then check that they are defined in the locale files
  const allKeysMap = {}

  filenames.forEach((filename) => {

    // Skip certain files
    if (/fake-exercises/.test(filename) || /tos-template/.test(filename)) {
      return
    }

    const contents = fs.readFileSync(filename)
    const document = jsdom.jsdom(`<html><body>${contents}</body></html>`)
    const $ = jquery(document.defaultView)

    // Find all the data-l10n-id attributes and look up to see if entries exist in all the languages
    $('[data-l10n-id]').each((index, el) => {
      const key = el.getAttribute('data-l10n-id')
      allKeysMap[key] = true
    })

    // Remove any text inside elements that are marked with a data-l10n-id
    // TODO: Verify all data-l10n-id values are in the JSON (warn if not in the polish ones)
    $('[data-l10n-id]').contents().remove()

    // Handlebars has `{{ logic-here }}` brackets as text nodes so remove them
    $('*').each((index, el) => {
      const text = el.textContent
      // HACK a crude way to remove handlebars
      if (/\{\{/.test(text)) {
        el.textContent = ''
      }
    })

    // Remove the <noscript> element
    $('noscript,script,title,style').remove()

    // Remove the annoying "X" for closing the dialog
    $('[aria-hidden="true"]').remove()

    // ./src/scripts/pages/about/contact/contact-template.html has the "Contact us" address
    // maybe exclude the entire file?
    $('.contact > p').remove()

    const remainingDocumentText = $('body').text().trim() // document.documentElement.innerText
    if (remainingDocumentText.length !== 0) {
      console.error(`ERROR: Non-internationalized text found in ${filename}`);
      console.log('-------------------------- HTML: --------------------------');
      console.log(document.documentElement.innerHTML);
      console.log('-------------------------- REMAINING TEXT: --------------------------');
      console.log(remainingDocumentText);
      console.log('----------------------------------------------------');
      process.exit(1)
    }
  })

  // Check that all the keys are defined in the language files
  glob('./src/locale/*/dictionary.ftl', (err, languageFiles) => {

    languageFiles.forEach((languageFile) => {
      const languageContent = fs.readFileSync(languageFile)
      const allKeys = Object.keys(allKeysMap)
      for (const i in allKeys) {
        const key = allKeys[i]

        if (languageContent.indexOf(`${key} =`) < 0) {

          if (key.indexOf('{') < 0) {
            console.error(`BUG: Missing key in ${languageFile}: '${key}'`)
            process.exit(1)
          } else {
            console.warn(`WARN: Skipping key because it is dynamically constructed: '${key}'`)
          }
        }
      }

    })
  })
})
