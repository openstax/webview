define (require) ->
  Handlebars = require('Handlebars')

  Handlebars.registerHelper 'percent', (value, divisor) ->
    return value / divisor * 100
