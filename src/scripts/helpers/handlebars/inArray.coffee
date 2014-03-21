define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'inArray', (array = [], value, options) ->
    array = array?() or array
    value = value?() or value
    if value in array then options.fn this else options.inverse this
