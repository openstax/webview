define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'titleForUrl', (title) ->
    title.replace(/\s/g,'_').substring(0,30)
