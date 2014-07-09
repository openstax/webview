define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  TocSectionView = require('cs!./toc/section')
  AddPopoverView = require('cs!./popovers/add/add')
  template = require('hbs!./contents-template')
  require('less!./contents')

  return class ContentsView extends BaseView
    template: template

    regions:
      toc: '.toc'

    events:
      'dragstart .toc [draggable]': 'onDragStart'
      'dragend .toc [draggable]': 'onDragEnd'

    initialize: () ->
      super()
      @listenTo(@model, 'change:editable removeNode moveNode add:contents', @render)

    onRender: () ->
      @regions.toc.show new TocSectionView
        model: @model

      @regions.self.append new AddPopoverView
        model: @model
        owner: @$el.find('.add.btn')

    onDragStart: (e) ->
      # Prevent children from interfering with drag events
      @$el.find('[draggable]').children().css('pointer-events', 'none')

    onDragEnd: (e) ->
      # Restore pointer events
      @$el.find('[draggable]').children().css('pointer-events', 'auto')

      # Reset styling for all draggable elements
      e.currentTarget.className = ''
