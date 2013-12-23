define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'is', (value, test, options) ->
    if value is test then options.fn(@) else options.inverse(@)
