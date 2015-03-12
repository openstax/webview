define (require) ->
  _ = require('underscore')
  BaseView = require('cs!helpers/backbone/views/base')
  PublishListPageView = require('cs!./page')
  template = require('hbs!./section-template')
  require('less!./section')

  # TODO: Write a simple inheritable for displaying the toc as a tree
  #       and use that inheritable for the Publish List and the ToC

  return class PublishListSectionView extends BaseView
    template: template
    itemViewContainer: '> ul'

    initialize: () ->
      @regions =
        container: @itemViewContainer

      super()
      @listenTo(@model, 'change:unit change:changed', @render)

    onRender: () ->
      super()

      @regions.container.empty()

      nodes = @model.get('contents')?.models

      _.each nodes, (node) =>
        if node.isSection()
          @regions.container.appendAs 'li', new PublishListSectionView
            model: node
        else
          @regions.container.appendAs 'li', new PublishListPageView
            model: node
            collection: @model
