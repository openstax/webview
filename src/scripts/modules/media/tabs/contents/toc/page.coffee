define (require) ->
  $ = require('jquery')
  linksHelper = require('cs!helpers/links')
  router = require('cs!router')
  analytics = require('cs!helpers/handlers/analytics')
  TocDraggableView = require('cs!./draggable')
  template = require('hbs!./page-template')

  return class TocPageView extends TocDraggableView
    template: template
    templateHelpers: () ->
      pageNumber = @content.getPageNumber(@model)
      isIntroduction =  @model.get('_parent')?.introduction?() is @model
      searchResult = @model.get('searchResult')
      return {
        page: pageNumber
        url: linksHelper.getPath('contents', {model: @content, page: pageNumber})
        editable: @editable
        isIntroduction: isIntroduction
        searchResult: searchResult
        visible: @model.get('visible') and (not isIntroduction or searchResult)
      }

    tagName: 'li'
    itemViewContainer: '.section'

    events:
      'click a': 'changePage'
      'click .remove': 'removeNode'

    initialize: () ->
      super()
      @content = @model.get('book')
      @editable = @content.get('editable')
      @listenTo(@model, 'change:active change:page change:changed change:title', @render)

    changePage: (e) ->
      # Don't intercept cmd/ctrl-clicks intended to open a link in a new tab
      return if e.metaKey or e.which isnt 1

      e.preventDefault()
      e.stopPropagation()

      $link = $(e.currentTarget)
      router.navigate $link.attr('href'), {trigger: false}, () => @trackNav()
      @model.get('book').setPage($link.data('page'))

    trackNav: () ->
      tree = @collection.get('book') or @collection
      analyticsID = tree.get('googleAnalytics')
      analytics.send(analyticsID) if analyticsID

    removeNode: () -> @content.removeNode(@model)
