define (require) ->
  $ = require('jquery')
  linksHelper = require('cs!helpers/links')
  router = require('cs!router')
  analytics = require('cs!helpers/handlers/analytics')
  TocDraggableView = require('cs!./draggable')
  template = require('hbs!./page-template')
  require('less!./page')

  return class TocPageView extends TocDraggableView
    template: template
    templateHelpers:
      page: () -> @content.getPageNumber(@model)
      url: () -> linksHelper.getPath('contents', {model: @content})
      editable: () -> @editable

    tagName: 'li'
    itemViewContainer: '.section'

    events:
      'click a': 'changePage'
      'click .remove': 'removeNode'

    initialize: () ->
      super()

      @content = @model.get('book')
      @editable = @content.get('editable')

      # If this is the active page, update the URL bar to the correct page number
      if @model.get('active')
        href = linksHelper.getPath 'contents',
          model: @content
          page: @model.getPageNumber()
        router.navigate(href, {trigger: false, analytics: false})

      @listenTo(@model, 'change:active change:page change:changed change:title', @render)

    scrollToContentTop: () ->
      $mediaNav = $('.media-nav').first()
      minY = $mediaNav.offset().top + $mediaNav.height() + 200
      y = (window.pageYOffset or document.documentElement.scrollTop) + $(window).height()

      $('body').animate({scrollTop: $mediaNav.offset().top}, '500', 'swing') if minY > y

    changePage: (e) ->
      e.preventDefault()
      e.stopPropagation()

      $link = $(e.currentTarget)
      @model.get('book').setPage($link.data('page'))
      router.navigate $link.attr('href'), {trigger: false}, () => @trackNav()
      @scrollToContentTop()

    trackNav: () ->
      tree = @collection.get('book') or @collection
      analyticsID = tree.get('googleAnalytics')
      analytics.send(analyticsID) if analyticsID

    removeNode: () -> @content.removeNode(@model)
