define (require) ->
  $ = require('jquery')
  linksHelper = require('cs!helpers/links')
  router = require('cs!router')
  analytics = require('cs!helpers/handlers/analytics')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./nav-template')
  require('less!./nav')

  return class MediaNavView extends BaseView
    template: template
    templateHelpers: () ->
      model = @model.toJSON()
      page = @model.getPageNumber()
      nextPage = @model.getNextPage()
      previousPage = @model.getPreviousPage()

      if page isnt nextPage
        next = linksHelper.getPath('contents', {id: model.id, version: model.version, page: nextPage})
      if page isnt previousPage
        back = linksHelper.getPath('contents', {id: model.id, version: model.version, page: previousPage})

      return {
        _hideProgress: @hideProgress
        next: next
        back: back
        pages: if @model.get('loaded') then @model.getTotalPages() else 0
        page: if @model.get('loaded') then @model.getPageNumber() else 0
      }

    initialize: (options) ->
      super()
      @hideProgress = options.hideProgress

      @listenTo(@model, 'changePage removeNode moveNode add', @render)

    events:
      'click .next': 'nextPage'
      'click .back': 'previousPage'

    nextPage: (e) ->
      @model.nextPage()
      @changePage(e)

    previousPage: (e) ->
      @model.previousPage()
      @changePage(e)

    changePage: (e) ->
      e.preventDefault()
      e.stopPropagation()
      href = $(e.currentTarget).attr('href')
      router.navigate href, {trigger: false}, () => @trackNav()
      @scrollToTop()

    trackNav: () ->
      analyticsID = @model.get('googleAnalytics')
      analytics.send(analyticsID) if analyticsID

    scrollToTop: () ->
      $mediaNav = $('.media-nav').first()
      maxY = $mediaNav.offset().top + $mediaNav.height()
      y = window.pageYOffset or document.documentElement.scrollTop

      window.scrollTo(0, maxY) if y > maxY
