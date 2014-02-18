define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'inArray', (array, value, options) ->
    unless array? and value?
      array = array?() or array or []
      value = value?() or value
      if value in array then options.fn this else options.inverse this
    else
      throw new Error '{{inArray}} takes two arguments (array, string|number).'
