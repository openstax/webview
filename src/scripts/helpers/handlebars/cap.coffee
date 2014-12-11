define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'cap', (str) ->
    cap = str.charAt(0).toUpperCase()
    format = str.substring(1).replace('_', ' ')
    return "#{cap}#{format}"
