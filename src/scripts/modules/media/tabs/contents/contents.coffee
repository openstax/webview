define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  TocTreeView = require('cs!./tree/tree')
  template = require('hbs!./contents-template')
  require('less!./contents')

  return class ContentsView extends BaseView
    template: template

    regions:
      toc: '.toc'

    initialize: () ->
      super()
      @listenTo(@model, 'change:editable removeNode', @render)

    onRender: () ->
      @regions.toc.show new TocTreeView
        model: @model
        editable: @model.get('editable')
        content: @model
