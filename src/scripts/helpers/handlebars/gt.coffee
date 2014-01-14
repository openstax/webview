define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'gt', (value, test, options) ->
    if value > test then options.fn(@) else options.inverse(@)
