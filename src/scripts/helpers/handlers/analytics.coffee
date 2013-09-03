define (require, exports, module) ->
  Backbone = require('backbone')

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

      # Asynchronously load analytics.js.
      require(['https://www.google-analytics.com/analytics.js'])

      #
      # # ga.js
      #

      # ## Setup ga.js
      window._gaq ?= []
      window._gaq.push(['_setAccount', module.config().analyticsID])

      # Asynchronously load ga.js
      require(['https://www.google-analytics.com/ga.js'])

    # Wrapper function to add analytics events
    ga: () -> if window.ga then window.ga.apply(@, arguments) # analytics.js
    gaq: () -> if window._gaq then window._gaq.push(arguments) # ga.js

    # Send the current page to every analytics service
    send: () ->
      fragment = Backbone.history.fragment
      if not /^\//.test(fragment) then fragment = '/' + fragment

      @ga('send', 'pageview')
      @gaq(['_trackPageview', fragment])
