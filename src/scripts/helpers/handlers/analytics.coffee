define (require, exports, module) ->
  Backbone = require('backbone')
  router = require('cs!router')

  # Class to handle loading analytics scripts and wrapping
  # handlers around them so that modules don't have to
  # interact with global variables directly
  return new class AnalyticsHandler
    constructor: () ->
      #
      # # analytics.js
      #

      # Setup temporary analytics.js objects
      window.GoogleAnalyticsObject = 'ga'
      window.ga = () -> (window.ga.q ?= []).push(arguments)
      window.ga.l = 1 * new Date()

      # Initialize analytics.js account
      window.ga('create', module.config().analyticsID)

      # Add tracking with analytics.js
      router.on 'route', () ->
        AnalyticsHandler.ga('send', 'pageview')

      # Asynchronously load analytics.js.
      require(['https://www.google-analytics.com/analytics.js'])

      #
      # # ga.js
      #

      # ## Setup ga.js
      window._gaq ?= []
      window._gaq.push(['_setAccount', module.config().analyticsID])

      # ## Add tracking with ga.js
      loadUrl = Backbone.History.prototype.loadUrl
      Backbone.History::loadUrl = () ->
        matched = loadUrl.apply(@, arguments)
        fragment = @fragment
        if not /^\//.test(fragment) then fragment = '/' + fragment
        AnalyticsHandler.gaq(['_trackPageview', fragment])
        return matched

      # Asynchronously load ga.js
      require(['https://www.google-analytics.com/ga.js'])

    # Wrapper functions to add analytics events
    @ga: () -> window.ga?.apply(@, arguments) # analytics.js
    @gaq: () -> window._gaq?.push(arguments) # ga.js

    # Send the current page to every analytics service
    send: () ->
      fragment = Backbone.history.fragment
      if not /^\//.test(fragment) then fragment = '/' + fragment

      AnalyticsHandler.ga('send', 'pageview')
      AnalyticsHandler.gaq(['_trackPageview', fragment])
