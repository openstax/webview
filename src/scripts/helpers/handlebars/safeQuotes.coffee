define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'safeQuotes', (str) ->
    return str.replace /(['"])/g, "\\$1"
