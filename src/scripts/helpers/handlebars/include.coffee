define (require) ->
  Handlebars = require('Handlebars')

  Handlebars.registerHelper 'include', (html) ->
    return new Handlebars.SafeString(html)
