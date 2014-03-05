define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')

  return class TocDraggableView extends BaseView
    events:
      # Drag and Drop events
      'dragstart > div': 'onDragStart'
      'dragover > div': 'onDragOver'
      'dragenter > div': 'onDragEnter'
      'dragleave > div': 'onDragLeave'
      'drop > div': 'onDrop'

    onDragStart: (e) ->
      e = e.originalEvent
      e.dataTransfer.effectAllowed = 'move'
      TocDraggableView.dragging = @model

    onDragOver: (e) ->
      e = e.originalEvent
      if e.preventDefault then e.preventDefault()
      e.dataTransfer.dropEffect = 'move'
      return false

    onDragEnter: (e) ->
      $(e.currentTarget).css('border-bottom', '3px solid #6ea244')

    onDragLeave: (e) ->
      $(e.currentTarget).css('border-bottom', '3px solid transparent')

    onDrop: (e) ->
      if e.stopPropagation then e.stopPropagation()

      if TocDraggableView.dragging isnt @model
        @model = @content.move(TocDraggableView.dragging, @model, 'after')

      return false
