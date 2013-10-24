define (require) ->
  Handlebars = require('Handlebars')

  Handlebars.registerHelper 'gt', (value, test, options) ->
    if value > test then options.fn(@) else options.inverse(@)
