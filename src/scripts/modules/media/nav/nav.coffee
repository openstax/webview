define (require) ->
  $ = require('jquery')
  linksHelper = require('cs!helpers/links')
  analytics = require('cs!helpers/handlers/analytics')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./nav-template')
  require('less!./nav')

  return class MediaNavView extends BaseView
    template: template
    templateHelpers: () ->
      model = @model.toJSON()
      nextPage = @model.getNextPage()
      previousPage = @model.getPreviousPage()

      if model.page isnt nextPage
        next = linksHelper.getPath('contents', {id: model.id, version: model.version, page: nextPage})
      if model.page isnt previousPage
        back = linksHelper.getPath('contents', {id: model.id, version: model.version, page: previousPage})

      return {_hideProgress: @hideProgress, next: next, back: back}

    initialize: (options) ->
      super()
      @hideProgress = options.hideProgress

      @listenTo(@model, 'change:page change:pages', @render)

    events:
      'click .next': 'nextPage'
      'click .back': 'previousPage'

    nextPage: () ->
      @trackNav(@model.nextPage())
      @scrollToTop()

    previousPage: () ->
      @trackNav(@model.previousPage())
      @scrollToTop()

    trackNav: (page) ->
      analyticsID = @model.get('googleAnalytics')
      fragment = "contents/#{@model.get('id')}:#{page}"
      analytics.send(analyticsID, fragment) if analyticsID

    scrollToTop: () ->
      $mediaNav = $('.media-nav').first()
      maxY = $mediaNav.offset().top + $mediaNav.height()
      y = window.pageYOffset or document.documentElement.scrollTop

      window.scrollTo(0, maxY) if y > maxY
