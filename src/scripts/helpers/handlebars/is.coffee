define (require) ->
  Handlebars = require('Handlebars')

  Handlebars.registerHelper 'is', (value, test, options) ->
    if value is test then options.fn(@) else options.inverse(@)
