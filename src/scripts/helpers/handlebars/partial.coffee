define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'partial', (template, options) ->
    partial = Handlebars.partials[template]

    if typeof partial is 'string'
      partial = Handlebars.compile(partial)
      Handlebars.partials[template] = partial

    context = $.extend({}, this, options.hash)

    return new Handlebars.SafeString partial(context)
