define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'convertToSize', (bytes) ->
    sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB']
    i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)))
    return (bytes / Math.pow(1024, i)).toFixed(1) + ' ' + sizes[i]
