define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'percent', (value, divisor) ->
    return value / divisor * 100
