define [
  'jquery'
  'mockjax'
], ($) ->

  # GET

  $.mockjax (settings) ->
    # settings.url == '/content/<uuid>'
    service = settings.url.match(/\/content\/(.*)$/)

    if service
      return {proxy: '/test/data/' + service[1] + '.json'}
