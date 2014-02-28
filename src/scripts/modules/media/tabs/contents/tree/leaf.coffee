define (require) ->
  $ = require('jquery')
  linksHelper = require('cs!helpers/links')
  router = require('cs!router')
  analytics = require('cs!helpers/handlers/analytics')
  TocDraggableView = require('cs!./draggable')
  template = require('hbs!./leaf-template')
  require('less!./leaf')

  return class TocNodeView extends TocDraggableView
    template: template
    templateHelpers:
      page: () -> @content.getPageNumber(@model)
      url: () -> linksHelper.getPath('contents', {id: @content.get('id'), version: @content.get('version')})
      editable: () -> @editable

    tagName: 'li'
    itemViewContainer: '.subcollection'

    events:
      'click a': 'changePage'
      'click .remove': 'removeNode'

      # Drag and Drop events
      'dragstart > div': 'onDragStart'
      'dragover > div': 'onDragOver'
      'dragenter > div': 'onDragEnter'
      'dragleave > div': 'onDragLeave'
      'drop > div': 'onDrop'

    initialize: () ->
      super()

      @content = @model.get('book')
      @editable = @content.get('editable')

      # If this is the active page, update the URL bar to the correct page number
      if @model.get('active')
        href = linksHelper.getPath 'contents',
          id: @content.get('id')
          version: @content.get('version')
          page: @model.getPageNumber()
        router.navigate(href, {trigger: false, analytics: false})

      @listenTo(@model, 'change:active change:page change:changed change:title', @render)

    changePage: (e) ->
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
