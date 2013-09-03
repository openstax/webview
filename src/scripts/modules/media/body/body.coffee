define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./body-template')
  require('less!./body')

  return class MediaBodyView extends BaseView
    template: () -> template @model.toJSON()

    initialize: () ->
      super()
      @model = @model.get('currentPage')

      @listenTo(@model, 'all', @render) # FIXME: Only listen to relevant events
