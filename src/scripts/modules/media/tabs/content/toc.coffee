define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')
  TocNodeView = require('cs!./node')
  template = require('hbs!./toc-template')
  require('less!./toc')

  return class TocTreeView extends BaseView
    template: template
    itemView: TocNodeView
    itemViewContainer: 'ul'
    maxDepth: 3

    events:
      'click .contents .subcollection': 'toggleSubcollection'

    initialize: () ->
      @regions =
        container: @itemViewContainer

      super()
      @listenTo(@model, 'change', @render) if @model

    onRender: () ->
      @regions.container.show(new TocNodeView({model: @model}))

    toggleSubcollection: (e) ->
      $(e.currentTarget).parent().siblings('ul').toggle()
