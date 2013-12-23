define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'include', (html) ->
    if html is null or html is undefined then return
    return new Handlebars.SafeString(html)
