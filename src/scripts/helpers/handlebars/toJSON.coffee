define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'toJSON', (obj) ->
    return new Handlebars.SafeString(JSON.stringify(obj))
