define (require) ->
  Backbone = require('backbone')
  settings = require('settings')

  # Class to handle loading analytics scripts and wrapping
  # handlers around them so that modules don't have to
  # interact with global variables directly
  return new class AnalyticsHandler
    constructor: () ->
      # Setup temporary analytics.js objects
      # window.GoogleAnalyticsObject = 'ga'
      # window.ga = () -> (window.ga.q ?= []).push(arguments)
      # window.ga.l = 1 * new Date()

      # Initialize analytics.js account
      # window.ga('create', settings.analyticsID, 'auto')

      # ## Setup ga.js
      window._gaq ?= []

      # Asynchronously load analytics.js.
      # require(['https://www.google-analytics.com/analytics.js'])

      # Asynchronously load ga.js
      require(['https://www.google-analytics.com/ga.js'])

    # Wrapper functions to add analytics events
    # ga: () -> window.ga?.apply(@, arguments) # analytics.js
    gaq: () ->
      console.log arguments[0] + ', ' + arguments[1]
      window._gaq?.push(arguments[0], arguments[1]) # ga.js

    # Send the current page to every analytics service
    send: (account) ->
      fragment = Backbone.history.fragment
      if not /^\//.test(fragment) then fragment = '/' + fragment

      # Use the default analytics ID in settings if no account is specified
      account ?= settings.analyticsID

      # @ga('send', 'pageview')
      @gaq(['_setAccount', account], ['_trackPageview', fragment])
