define (require) ->
  _ = require('underscore')
  Handlebars = require('Handlebars')

  Handlebars.registerHelper 'recursive', (template, context, options) ->
    f = Handlebars.partials[template]
    if typeof f isnt 'function' then return ''

    return new Handlebars.SafeString(f(context))
