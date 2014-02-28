define (require) ->
  _ = require('underscore')
  BaseView = require('cs!helpers/backbone/views/base')
  TocLeafView = require('cs!./leaf')
  template = require('hbs!./tree-template')
  require('less!./tree')

  return class TocTreeView extends BaseView
    template: template
    templateHelpers:
      editable: () -> @editable
      expanded: () -> @model.expanded
    itemViewContainer: '> ul'

    events:
      'click > div > span > .subcollection': 'toggleSubcollection'
      'click > div > .remove': 'removeNode'

    initialize: () ->
      @content = @model.get('book') or @model
      @editable = @content.get('editable')
      @regions =
        container: @itemViewContainer

      super()
      @listenTo(@model, 'change:unit change:title change:subcollection', @render)

    onRender: () ->
      @regions.container.empty()

      nodes = @model.get('contents')?.models

      _.each nodes, (node) =>
        if node.get('subcollection')
          @regions.container.appendAs 'li', new TocTreeView
            model: node
        else
          @regions.container.appendAs 'li', new TocLeafView
            model: node
            collection: @model

    toggleSubcollection: (e) ->
      if @model.expanded
        @model.expanded = false
        @$el.children().removeClass('expanded')
      else
        @model.expanded = true
        @$el.children().addClass('expanded')

    removeNode: () ->
      @content.removeNode(@model)
