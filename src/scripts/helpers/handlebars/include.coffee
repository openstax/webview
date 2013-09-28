define (require) ->
  Handlebars = require('Handlebars')

  Handlebars.registerHelper 'include', (html) ->
    if html is null or html is undefined then return
    return new Handlebars.SafeString(html)
