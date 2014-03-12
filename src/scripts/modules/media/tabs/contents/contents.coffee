define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  TocTreeView = require('cs!./tree/tree')
  AddPopoverView = require('cs!./popovers/add/add')
  template = require('hbs!./contents-template')
  require('less!./contents')

  return class ContentsView extends BaseView
    template: template

    regions:
      toc: '.toc'
      button: '.add.btn'

    events:
      'dragstart .toc .draggable': 'onDragStart'
      'dragend .toc .draggable': 'onDragEnd'

    initialize: () ->
      super()
      @listenTo(@model, 'change:editable removeNode moveNode add', @render)

    onRender: () ->
      @regions.toc.show new TocTreeView
        model: @model

      @regions.button.show new AddPopoverView
        model: @model
        owner: @$el.find('.add.btn')

    onDragStart: (e) ->
      # Prevent children from interfering with drag events
      @$el.find('.draggable').children().css('pointer-events', 'none')

    onDragEnd: (e) ->
      $draggable = @$el.find('.draggable')
      # Restore pointer events
      $draggable.children().css('pointer-events', 'auto')

      # Reset styling for all draggable elements
      $draggable.removeClass('before after insert')
