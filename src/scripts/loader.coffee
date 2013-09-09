define (require) ->
  $ = require('jquery')
  Backbone = require('backbone')
  router = require('cs!router')
  analytics = require('cs!helpers/handlers/analytics') # Setup Analytics Handler

  # The root URI prefixed on all non-external AJAX and Backbone URIs
  root = '/'

  init = (options = {}) ->
    # Append /test to the root if the app is in test mode
    if options.test
      root += 'test/'

    external = new RegExp('^((f|ht)tps?:)?//')

    # Catch internal application links and let Backbone handle the routing
    $(document).on 'click', 'a:not([data-bypass])', (e) ->
      href = $(this).attr('href')

      # Only handle links intended to be processed by Backbone
      if e.isDefaultPrevented() or href.charAt(0) is '#' or
        (href.length > 9 and href.substring(0,7) is 'mailto:') then return

      e.preventDefault()

      if external.test(href)
        window.open(href, '_blank')
      else
        router.navigate(href, {trigger: true})

    Backbone.history.start
      pushState: true
      root: root

    # Prefix all non-external AJAX requests with the root URI
    $.ajaxPrefilter (options, originalOptions, jqXHR) ->
      if not external.test(options.url)
        options.url = root + options.url

      return

  return {init: init}
