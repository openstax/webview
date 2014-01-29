define (require) ->
  Handlebars = require('hbs/handlebars')

  convertDate = (date) ->
    options = {year: 'numeric', month: 'short', day: 'numeric'}
    return date.toLocaleDateString(navigator.language, options)

  Handlebars.registerHelper 'date', (period) ->
    if period instanceof Date
      html = convertDate(period)
    else
      date = new Date()
      switch period
        when 'year' then html = date.getFullYear()
        when 'month' then html = date.toLocaleDateString(navigator.language, {month: "long"})
        when 'day' then html = date.toLocaleDateString(navigator.language, {day: "numeric"})
        when 'weekday' then html = date.toLocaleDateString(navigator.language, {weekday: "long"})
        else html = convertDate(new Date(period))

    return new Handlebars.SafeString(html.toString())
