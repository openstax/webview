define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')

  return class TocDraggableView extends BaseView
    onDragStart: (e) ->
      e.originalEvent.dataTransfer.effectAllowed = 'move'
      TocDraggableView.dragging = @model

    onDragEnter: (e) ->
      e.currentTarget.style.borderBottom = '3px solid #6ea244'

    onDragLeave: (e) ->
      e.currentTarget.style.borderBottom = '3px solid transparent'

    onDrop: (e) ->
      if e.stopPropagation then e.stopPropagation()

      if TocDraggableView.dragging isnt @model
        @model = @content.move(TocDraggableView.dragging, @model, 'after')

      return false
