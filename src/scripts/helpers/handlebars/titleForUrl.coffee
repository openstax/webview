define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'titleForUrl', (title) ->
    title.replace(/\ /g,'_').substring(0,30)
