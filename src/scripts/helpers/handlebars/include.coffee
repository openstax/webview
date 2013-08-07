define [
  'Handlebars'
], (Handlebars) ->

  Handlebars.registerHelper 'include', (html) ->
    return new Handlebars.SafeString(html)
