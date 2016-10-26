define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'mapField', (list, keyword) ->
    list = list || []
    return list.map((element) -> element[keyword])
