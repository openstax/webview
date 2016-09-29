define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'mapField', (list, keyword) ->
    return list.map((element) => element[keyword])
