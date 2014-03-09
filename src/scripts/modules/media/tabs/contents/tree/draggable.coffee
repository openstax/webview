define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')

  return class TocDraggableView extends BaseView
    onDragStart: (e) ->
      e.dataTransfer.effectAllowed = 'move'
      TocDraggableView.dragging = @model # Track the model being dragged on this class

    onDragOver: (e) ->
      e.preventDefault()
      $el = $(e.target)
      pHeight = $el.outerHeight()
      pOffset = $el.offset()
      y = e.pageY - pOffset.top

      e.dataTransfer.dropEffect = 'move'

      if pHeight/2 > y
        e.target.style.borderTop = '3px solid #6ea244'
        e.target.style.borderBottom = '3px solid transparent'
      else
        e.target.style.borderTop = '3px solid transparent'
        e.target.style.borderBottom = '3px solid #6ea244'

      return false

    onDragLeave: (e) ->
      e.target.style.borderTop = '3px solid transparent'
      e.target.style.borderBottom = '3px solid transparent'

    onDrop: (e) ->
      if e.stopPropagation then e.stopPropagation()

      $el = $(e.target)
      pHeight = $el.outerHeight()
      pOffset = $el.offset()
      y = e.pageY - pOffset.top

      if pHeight/2 > y
        position = 'before'
      else
        position = 'after'

      # Reorganize the content's toc internal data representation
      if TocDraggableView.dragging isnt @model
        @model = @content.move(TocDraggableView.dragging, @model, position)

      return false

    onRender: () ->
      super()

      if @editable and @model.get('book')
        draggable = @$el.children('.draggable').get(0)

        draggable.addEventListener('dragstart', ((e) => @onDragStart.call(@, e)), false)
        draggable.addEventListener('dragover', @onDragOver, false)
        draggable.addEventListener('dragleave', @onDragLeave, false)
        draggable.addEventListener('drop', ((e) => @onDrop.call(@, e)), false)
        #@el.addEventListener('dragend', @onDragEnd, false)
