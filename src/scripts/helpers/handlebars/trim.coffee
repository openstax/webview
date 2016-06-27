define (require) ->
  Handlebars = require('hbs/handlebars')

  trim = (str = '') ->
    temp = document.createElement("div")
    temp.innerHTML = str
    str = temp.textContent
    str.replace(/\s/g, '-').replace(/[^a-zA-Z0-9 -]/g, '').substring(0, 30)

  Handlebars.registerHelper 'trim', (str) -> trim(str)

  # Return trim so it can be used outside of Handlebars
  return trim
