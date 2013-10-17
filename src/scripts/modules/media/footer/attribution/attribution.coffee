define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./attribution-template')
  require('less!./attribution')

  return class AttributionView extends BaseView
    template: template

    initialize: () ->
      super()
      @listenTo(@model, 'changePage changePage:content', @render)
