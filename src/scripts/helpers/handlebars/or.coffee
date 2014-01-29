define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'or', (testA, testB, options) ->
    if testA or testB then options.fn(@) else options.inverse(@)
