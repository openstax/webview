define (require) ->
  $ = require('jquery')
  require('mockjax')

  # GET

  $.mockjax (settings) ->
    # settings.url == '/contents/<uuid>'
    service = settings.url.match(/\/contents\/(.*)$/)

    if service
      return {proxy: 'data/' + service[1] + '.json'}
