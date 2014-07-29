# This helper is a hack to get around the limitation of not being able
# to pass a value to an array outside the current scope in hbs
# (ie: `{{../authorList.index.fullname}}`)

define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'author', (list, index, property) ->
    return new Handlebars.SafeString(list[index][property])
