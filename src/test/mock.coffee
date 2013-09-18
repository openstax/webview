define (require) ->
  $ = require('jquery')
  require('mockjax')

  # GET

  $.mockjax (settings) ->
    # settings.url == '/contents/<uuid>'
    service = settings.url.match(/\/contents\/(.*)$/)

    if service
      return {proxy: 'data/' + service[1] + '.json'}

  $.mockjax (settings) ->
    # settings.url == '/search?q=physics'
    service = settings.url.match(/\/search\?q=physics$/)

    if service
      return {proxy: 'data/search.json'}
