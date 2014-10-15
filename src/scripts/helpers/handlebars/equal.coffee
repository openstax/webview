define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'equal', (lvalue, rvalue, options) ->
    unless lvalue is rvalue
      options.inverse this
    else
      options.fn this
