define (require) ->
  Handlebars = require('Handlebars')

  Handlebars.registerHelper 'isnt', (value, test, options) ->
    if value isnt test then options.fn(@) else options.inverse(@)
