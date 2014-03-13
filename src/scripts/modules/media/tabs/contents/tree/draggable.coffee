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
      $(e.currentTarget).removeClass('before after insert')
      $(e.currentTarget).addClass(@getPosition(e))

    onDragLeave: (e) ->
      $(e.currentTarget).removeClass('before after insert')

    onDrop: (e) ->
      e.stopPropagation()

      position = @getPosition(e)

      # Reorganize the content's toc internal data representation
      if TocDraggableView.dragging isnt @model
        @model = @content.move(TocDraggableView.dragging, @model, position)

      return false

    onRender: () ->
      if @editable and @model.get('book')
        draggable = @$el.children('.draggable').get(0)

        onDragStart = ((e) => @onDragStart.call(@, e))
        onDragOver = ((e) => @onDragOver.call(@, e))
        onDrop = ((e) => @onDrop.call(@, e))

        # Attach event listeners using vanilla JS after the view has been rendered
        draggable.addEventListener('dragstart', onDragStart, false)
        draggable.addEventListener('dragover', onDragOver, false)
        draggable.addEventListener('dragleave', @onDragLeave, false)
        draggable.addEventListener('drop', onDrop, false)

        # Remove event listeners when the view is destroyed
        @onBeforeClose = () =>
          draggable.removeEventListener('dragstart', onDragStart, false)
          draggable.removeEventListener('dragover', onDragOver, false)
          draggable.removeEventListener('dragleave', @onDragLeave, false)
          draggable.removeEventListener('drop', onDrop, false)

      return @
