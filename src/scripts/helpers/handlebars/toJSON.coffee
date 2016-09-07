define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'toJSON', (list) ->
    arr = []
    for x in list
      arr.push x.fullname
    return new Handlebars.SafeString(JSON.stringify(arr))
