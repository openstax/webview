define (require) ->
  _ = require('underscore')
  TocDraggableView = require('cs!./draggable')
  TocPageView = require('cs!./page')
  template = require('hbs!./section-template')
  require('less!./section')

  return class TocSectionView extends TocDraggableView
    template: template
    templateHelpers:
      editable: () -> @editable
      expanded: () -> @model.expanded
    itemViewContainer: '> ul'

    events:
      'click > div > span > .section': 'toggleSection'
      'click > div > .remove': 'removeNode'
      'click > div > .edit': 'editNode'

    initialize: () ->
      @content = @model.get('book') or @model
      @editable = @content.get('editable')
      @regions =
        container: @itemViewContainer

      super()
      @listenTo(@model, 'change:unit change:title', @render)

    onRender: () ->
      super()

      @regions.container.empty()

      nodes = @model.get('contents')?.models

      _.each nodes, (node) =>
        if node.isSection()
          @regions.container.appendAs 'li', new TocSectionView
            model: node
        else
          @regions.container.appendAs 'li', new TocPageView
            model: node
            collection: @model

    toggleSection: (e) ->
      if @model.expanded
        @model.expanded = false
        @$el.children().removeClass('expanded')
      else
        @model.expanded = true
        @$el.children().addClass('expanded')

    removeNode: () ->
      @content.removeNode(@model)

    editNode: () ->
      title = prompt('Rename the section:', @model.get('title'))

      if title
        @model.set('title', title)
