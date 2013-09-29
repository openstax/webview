define (require) ->
  Handlebars = require('Handlebars')

  Handlebars.registerHelper 'lt', (value, test, options) ->
    if value < test then options.fn(@) else options.inverse(@)
