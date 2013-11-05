define (require) ->
  $ = require('jquery')
  require('mockjax')

  $.mockjaxSettings.responseTime = 500 # Set the mock latency for all requests

  # GET

  $.mockjax (settings) ->
    # settings.url === '/contents/<uuid>'
    service = settings.url.match(/\/contents\/(.*)$/)
    return {proxy: 'data/' + service[1] + '.json'} if service

  $.mockjax (settings) ->
    # settings.url === '/search?q=physics'
    service = settings.url.match(/\/search\?q=physics$/)
    return {proxy: 'data/search.json'} if service

  $.mockjax (settings) ->
    # settings.url === 'extras/<uuid>'
    service = settings.url.match(/\/extras\/(.*)$/)
    return {proxy: 'data/content-extras.json'} if service

  $.mockjax (settings) ->
    # settings.url === 'extras'
    service = settings.url.match(/\/extras$/)
    return {proxy: 'data/extras.json'} if service
