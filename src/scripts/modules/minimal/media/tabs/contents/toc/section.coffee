define (require) ->
  _ = require('underscore')
  TocDraggableView = require('cs!modules/media/tabs/contents/toc/draggable')
  TocPageView = require('cs!./page')
  template = require('hbs!modules/media/tabs/contents/toc/section-template')
  require('less!modules/media/tabs/contents/toc/section')

  return class TocSectionView extends TocDraggableView
    template: template
    templateHelpers:
      editable: () -> @editable
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

      @listenTo(@model, 'change:unit change:title change:expanded sync:contents', @render)

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
      if @model.get('expanded')
        @model.set('expanded', false)
      else
        @model.set('expanded', true)

    removeNode: () ->
      @content.removeNode(@model)

    editNode: () ->
      title = prompt('Rename the section:', @model.get('title'))

      if title
        @model.set('title', title)
        @model.set('changed', true)
        @model.get('book').set('childChanged', true)
        @model.get('book').set('changed', true)
