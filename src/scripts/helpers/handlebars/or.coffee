define (require) ->
  Handlebars = require('Handlebars')

  Handlebars.registerHelper 'or', (testA, testB, options) ->
    if testA or testB then options.fn(@) else options.inverse(@)
