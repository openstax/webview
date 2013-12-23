define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'isnt', (value, test, options) ->
    if value isnt test then options.fn(@) else options.inverse(@)
