define (require) ->
  Handlebars = require('hbs/handlebars')

  trim = (str = '') -> str.replace(/\s/g, '-').substring(0, 30)

  Handlebars.registerHelper 'trim', (str) -> trim(str)

  # Return trim so it can be used outside of Handlebars
  return trim
