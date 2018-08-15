define (require) ->
  Handlebars = require('hbs/handlebars')

  trim = (str = '') ->
    temp = document.createElement("div")
    temp.innerHTML = str
    str = temp.textContent
    # replace symbols with whitespace
    str = str.replace(/[\u2000-\u206F\u2E00-\u2E7F\\'!"#$%&()*+,\-.\/:;<=>?@\[\]^_`{|}~\s+]/g, ' ')
    # remove leading and trailing whitespace
    str = str.replace(/^\s+|\s+$/g, '')
    # replace spaces with dashes
    str = str.replace(/\s+/g, '-')

  Handlebars.registerHelper 'trim', (str) -> trim(str)

  # Return trim so it can be used outside of Handlebars
  return trim
