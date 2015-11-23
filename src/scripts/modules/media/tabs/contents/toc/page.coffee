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

      return {
        page: pageNumber
        url: linksHelper.getPath('contents', {model: @content, page: pageNumber})
        editable: @editable
        searchResult: @model.get('searchResult')
        visible: @model.get('visible')
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
      @listenTo(@model, 'change:active', @handleActiveChange)

    handleActiveChange: ->
      isActive = @model.get('active')
      for container in @model.containers()
        if isActive
          container.set('activeContainer', true)
        else if container.get('activeContainer')
          container.unset('activeContainer')

    changePage: (e) ->
      # Don't intercept cmd/ctrl-clicks intended to open a link in a new tab
      return if e.metaKey or e.which isnt 1

      e.preventDefault()
      e.stopPropagation()

      $link = $(e.currentTarget)
      @model.get('book').setPage($link.data('page'))
      router.navigate $link.attr('href'), {trigger: false}, () => @trackNav()

    trackNav: () ->
      tree = @collection.get('book') or @collection
      analyticsID = tree.get('googleAnalytics')
      analytics.send(analyticsID) if analyticsID

    removeNode: () -> @content.removeNode(@model)
