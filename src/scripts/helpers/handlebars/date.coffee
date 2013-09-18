define (require) ->
  Handlebars = require('Handlebars')

  MONTHS = [
    'January'
    'February'
    'March'
    'April'
    'May'
    'June'
    'July'
    'August'
    'September'
    'October'
    'November'
    'December'
  ]

  DAYS = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']

  convertDate = (date) ->
    month = MONTHS[date.getMonth()].substr(0,3)
    day = date.getDate()
    year = date.getFullYear()

    return "#{month} #{day}, #{year}"

  Handlebars.registerHelper 'date', (period) ->
    date = new Date()

    if period instanceof Date
      html = convertDate(period)
    else
      switch period
        when 'year' then html = date.getFullYear()
        when 'month' then html = MONTHS[date.getMonth()]
        when 'day' then html = DAYS[date.getDay()]
        else html = convertDate(new Date(period))

    return new Handlebars.SafeString(html.toString())
