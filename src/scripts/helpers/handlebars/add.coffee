define (require) ->
  Handlebars = require('Handlebars')

  Handlebars.registerHelper 'add', (value, addition) -> value + addition
