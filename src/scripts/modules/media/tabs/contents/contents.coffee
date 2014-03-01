define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  TocTreeView = require('cs!./tree/tree')
  template = require('hbs!./contents-template')
  require('less!./contents')

  return class ContentsView extends BaseView
    template: template

    regions:
      toc: '.toc'

    events:
      'dragstart .toc .draggable': 'onDragStart'
      'dragend .toc .draggable': 'onDragEnd'

    initialize: () ->
      super()
      @listenTo(@model, 'change:editable removeNode moveNode', @render)

    onRender: () ->
      @regions.toc.show new TocTreeView
        model: @model

    onDragStart: (e) ->
      # Prevent children from interfering with drag events
      @$el.find('[draggable]').children().css('pointer-events', 'none')

    onDragEnd: (e) ->
      # Restore pointer events
      @$el.find('[draggable]').children().css('pointer-events', 'auto')
