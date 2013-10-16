define (require) ->
  $ = require('jquery')
  router = require('cs!router')
  analytics = require('cs!helpers/handlers/analytics')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./nav-template')
  require('less!./nav')

  return class MediaNavView extends BaseView
    template: template
    templateHelpers:
      _hideProgress: () -> @hideProgress

    initialize: (options) ->
      super()
      @listenTo(@model, 'change:page change:pages', @render)
      @hideProgress = options.hideProgress

    events:
      'click .next': 'nextPage'
      'click .back': 'previousPage'

    nextPage: () ->
      @navigate(@model.nextPage())

    previousPage: () ->
      @navigate(@model.previousPage())

    navigate: (page) ->
      maxY = $('.media-header').offset().top
      y = window.pageYOffset || document.documentElement.scrollTop

      if y > maxY
        window.scrollTo(0, maxY)

      route = "/content/#{router.current().params[0]}:#{page}" # Deterimine the new route
      router.navigate(route) # Update browser URL to reflect the new route
      analytics.send() # Send the analytics information for the new route
