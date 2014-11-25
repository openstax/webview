define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'noVersion', (id) -> return id.split('@')[0]
