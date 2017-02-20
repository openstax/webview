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

    # Send the current page to every analytics service
    send: (account, fragment = Backbone.history.fragment) ->
      if not /^\//.test(fragment) then fragment = '/' + fragment

      require ['analytics'], (ga) =>
        # Use the default analytics ID in settings if no account is specified
        account ?= settings.analyticsID

        # TODO investigate if we need specific names for our tracker name
        trackerName = @getTrackerName(account)
        ga?('create', account, 'auto', trackerName)

        ga?("#{trackerName}.send", 'pageview', fragment)

    getTrackerName: (account) ->
      # Strip non-alphanumeric characters for default trackerName
      account.replace(/\W/g, '')
