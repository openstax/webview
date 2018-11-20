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
    sendAnalytics: (accounts, fragment = Backbone.history.fragment) ->

      # Use the default analytics ID in settings if no account is specified
      unless accounts
        accounts = [settings.analyticsID]

      # temporarily support a single field for analytics (sometimes it is `null`)
      unless Array.isArray(accounts)
        console.log 'Consider calling analytics.sendAnalytics with an Array'
        @sendAnalytics([accounts], fragment)

      require ['analytics'], (ga) =>

        # Uncomment me to log what would have been sent to `ga(...)` (for debugging)
        # ga = (a,b,c) ->
        #   console.log('Local Analytics function', a,b,c)

        accounts.forEach (account) =>
          if not /^\//.test(fragment) then fragment = '/' + fragment

          # TODO investigate if we need specific names for our tracker name
          trackerName = @getTrackerName(account)
          ga('create', account, 'auto', trackerName)

          ga("#{trackerName}.send", 'pageview', fragment)

    sendDownloadAnalytics: (accounts, bookTitle, fileType, url, fragment = Backbone.history.fragment) ->

      eventPacket = 
        eventCategory: fileType + ' ' + bookTitle,
        eventAction: fileType + ' Download'
        eventLabel: url,
        location: fragment,
        pageview: fragment,
        hitType: 'event'

      # Use the default analytics ID in settings if no account is specified
      unless accounts
        accounts = [settings.analyticsID]

      # temporarily support a single field for analytics (sometimes it is `null`)
      unless Array.isArray(accounts)
        console.log 'Consider calling analytics.sendAnalytics with an Array'
        @sendAnalytics([accounts], fragment)

      require ['analytics'], (ga) =>

        # Uncomment me to log what would have been sent to `ga(...)` (for debugging)
        # ga = (a,b,c) ->
        #   console.log('Local Analytics function', a,b,c)

        accounts.forEach (account) =>
          if not /^\//.test(fragment) then fragment = '/' + fragment

          # TODO investigate if we need specific names for our tracker name
          trackerName = @getTrackerName(account)
          ga('create', account, 'auto', trackerName)

          ga("#{trackerName}.send", eventPacket)

    getTrackerName: (account) ->
      # Strip non-alphanumeric characters for default trackerName
      account.replace(/\W/g, '')
