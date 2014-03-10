define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')

  return class TocDraggableView extends BaseView
    getPosition: (e) ->
      $target = $(e.target)
      pHeight = $target.outerHeight()
      pOffset = $target.offset()
      y = e.pageY - pOffset.top

      if @model.get('subcollection')
        if pHeight/3 > y
          position = 'before'
        else if pHeight*2/3 > y
          position = 'insert'
        else
          position = 'after'
      else
        if pHeight/2 > y
          position = 'before'
        else
          position = 'after'

      return position

    onDragStart: (e) ->
      e.dataTransfer.effectAllowed = 'move'
      TocDraggableView.dragging = @model # Track the model being dragged on this class

    onDragOver: (e) ->
      e.preventDefault()

      e.dataTransfer.dropEffect = 'move'

      position = @getPosition(e)

      if position is 'before'
        e.target.style.borderTop = '3px solid #6ea244'
        e.target.style.borderBottom = '3px solid transparent'
        e.target.style.backgroundColor = 'transparent'
      else if position is 'after'
        e.target.style.borderTop = '3px solid transparent'
        e.target.style.borderBottom = '3px solid #6ea244'
        e.target.style.backgroundColor = 'transparent'
      else
        e.target.style.borderTop = '3px solid transparent'
        e.target.style.borderBottom = '3px solid transparent'
        e.target.style.backgroundColor = 'rgba(110, 162, 68, 0.5)'

      return false

    onDragLeave: (e) ->
      e.target.style.borderTop = '3px solid transparent'
      e.target.style.borderBottom = '3px solid transparent'
      e.target.style.backgroundColor = 'transparent'

    onDrop: (e) ->
      if e.stopPropagation then e.stopPropagation()

      position = @getPosition(e)

      # Reorganize the content's toc internal data representation
      if TocDraggableView.dragging isnt @model
        @model = @content.move(TocDraggableView.dragging, @model, position)

      return false

    onRender: () ->
      super()

      if @editable and @model.get('book')
        draggable = @$el.children('.draggable').get(0)

        draggable.addEventListener('dragstart', ((e) => @onDragStart.call(@, e)), false)
        draggable.addEventListener('dragover', ((e) => @onDragOver.call(@, e)), false)
        draggable.addEventListener('dragleave', @onDragLeave, false)
        draggable.addEventListener('drop', ((e) => @onDrop.call(@, e)), false)
