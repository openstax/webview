define (require) ->
  Handlebars = require('hbs/handlebars')

  trim = (str = '') ->
    temp = document.createElement("div")
    temp.innerHTML = str
    str = temp.textContent
    str.replace(/[^\w\s]/g, '').replace(/\s/g, '-')

  Handlebars.registerHelper 'trim', (str) -> trim(str)

  # Return trim so it can be used outside of Handlebars
  return trim
