define (require) ->
  Handlebars = require('Handlebars')

  Handlebars.registerHelper 'date', (period) ->
    date = new Date()

    switch period
      when 'year' then html = date.getFullYear()
      else html = date

    return new Handlebars.SafeString(html.toString())
