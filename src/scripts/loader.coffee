define (require) ->
  $ = require('jquery')
  Backbone = require('backbone')
  router = require('cs!router')
  analytics = require('cs!helpers/handlers/analytics')

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

      # Don't handle navigation if the default handling was already prevented
      if e.isDefaultPrevented() or href.charAt(0) is '#' then return

      e.preventDefault()

      if external.test(href)
        window.open(href, '_blank')
      else
        router.navigate(href, {trigger: true})

    # Add tracking with ga.js
    loadUrl = Backbone.History.prototype.loadUrl
    Backbone.History::loadUrl = (fragmentOverride) ->
      matched = loadUrl.apply(@, arguments)
      gaFragment = @fragment
      if not /^\//.test(gaFragment) then gaFragment = '/' + gaFragment
      analytics.gaq(['_trackPageview', gaFragment])
      return matched

    # Add tracking with analytics.js
    router.on 'route', () ->
      analytics.ga('send', 'pageview')

    Backbone.history.start
      pushState: true
      root: root

    # Prefix all non-external AJAX requests with the root URI
    $.ajaxPrefilter ( options, originalOptions, jqXHR ) ->
      if not external.test(options.url)
        options.url = root + options.url

      return

  return {init: init}
