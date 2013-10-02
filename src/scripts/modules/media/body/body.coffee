define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./body-template')
  require('less!./body')

  return class MediaBodyView extends BaseView
    template: template

    initialize: () ->
      @model = @model.get('currentPage')
      super()
      @listenTo(@model, 'change', @render) if @model
