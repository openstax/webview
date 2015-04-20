define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'range', (value1, value2, test, options) ->
    if value1 < test and value2 > test then options.fn(@)
