define (require) ->
  Backbone = require('backbone')
  settings = require('settings')

  # Class to handle loading analytics scripts and wrapping
  # handlers around them so that modules don't have to
  # interact with global variables directly
  return new class AnalyticsHandler
    constructor: () ->
      # Setup temporary analytics.js objects
      window.GoogleAnalyticsObject = '__ga__'
      window.__ga__ =
        q: [['create', settings.analyticsID, 'auto']],
        l: Date.now()

      # ## Setup ga.js
      #window._gaq ?= []

      # Asynchronously load ga.js
      #require(['https://www.google-analytics.com/ga.js'])

    # Wrapper functions to add analytics events
    #ga: () -> ga?.apply(@, arguments) # analytics.js
    #gaq: () -> window._gaq?.push(arguments[0], arguments[1]) # ga.js

    # Send the current page to every analytics service
    send: (account, fragment = Backbone.history.fragment) ->
      if not /^\//.test(fragment) then fragment = '/' + fragment

      require ['analytics'], (ga) ->
        # Use the default analytics ID in settings if no account is specified
        account ?= settings.analyticsID
        # TODO investigate if we need a different name for our tracker name
        trackerName = 'cnxTracker'
        ga('create', account, 'auto', trackerName)

        ga("#{trackerName}.send", 'pageview', fragment)
        #@gaq(['_setAccount', account], ['_trackPageview', fragment])
