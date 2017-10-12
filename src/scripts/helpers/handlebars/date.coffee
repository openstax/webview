define (require) ->
  Handlebars = require('hbs/handlebars')

  convertDate = (date) ->
    # options = {year: 'numeric', month: 'short', day: 'numeric'}
    # return date.toLocaleDateString(navigator.language, options)
    return date.toLocaleDateString(navigator.language)

  Handlebars.registerHelper 'date', (period) ->
    if period instanceof Date
      html = convertDate(period)
    else
      date = new Date()
      switch period
        when 'year' then html = date.getFullYear()
        when 'month' then html = date.toLocaleDateString(navigator.language, {month: "numeric"})
        when 'day' then html = date.toLocaleDateString(navigator.language, {day: "numeric"})
        when 'weekday' then html = date.toLocaleDateString(navigator.language, {weekday: "numeric"})
        else html = convertDate(new Date(period))

    return new Handlebars.SafeString(html.toString())
