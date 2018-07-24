define (require) ->
  Handlebars = require('hbs/handlebars')

  trim = (str = '') ->
    temp = document.createElement("div")
    temp.innerHTML = str
    str = temp.textContent
    str.replace(/[\u2000-\u206F\u2E00-\u2E7F\\'!"#$%&()*+,\-.\/:;<=>?@\[\]^_`{|}~\s+]/g, '-')

  Handlebars.registerHelper 'trim', (str) -> trim(str)

  # Return trim so it can be used outside of Handlebars
  return trim
