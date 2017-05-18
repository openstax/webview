define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'stripTags', (str) ->
    return str.replace(/<\/?[^>]+(>|$)/g, '')
