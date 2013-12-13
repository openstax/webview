define (require) ->
  $ = require('jquery')
  linksHelper = require('cs!helpers/links')
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
      @listenTo(@model, 'change:page change:pages', @render)
      @hideProgress = options.hideProgress

    events:
      'click .next': 'nextPage'
      'click .back': 'previousPage'

    nextPage: () ->
      @model.nextPage()
      @scrollToTop()

    previousPage: () ->
      @model.previousPage()
      @scrollToTop()

    scrollToTop: () ->
      maxY = $('.media-header').offset().top
      y = window.pageYOffset or document.documentElement.scrollTop

      window.scrollTo(0, maxY) if y > maxY
