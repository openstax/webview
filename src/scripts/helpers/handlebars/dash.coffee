define (require) ->
  Handlebars = require('hbs/handlebars')

  dash = (str = '') -> str.replace(/_/g, '-')

  Handlebars.registerHelper 'dash', (str) -> dash(str)

  # Return dash so it can be used outside of Handlebars
  return dash
