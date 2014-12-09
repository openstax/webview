define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'noVersion', (id) -> id.split('@')[0]
