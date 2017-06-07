define (require) ->
  Handlebars = require('hbs/handlebars')
  stripTags = require('cs!../strip-tags.coffee')

  Handlebars.registerHelper 'stripTags', (str) ->
    return stripTags(str)
