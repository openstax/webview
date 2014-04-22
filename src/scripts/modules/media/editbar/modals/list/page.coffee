define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./page-template')
  require('less!./page')

  return class PublishListPageView extends BaseView
    template: template

    tagName: 'li'
    itemViewContainer: '.section'

    initialize: () ->
      super()

      @listenTo(@model, 'change:active change:page change:changed change:title', @render)
