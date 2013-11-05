define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./metadata-template')
  require('less!./metadata')

  return class MetadataView extends BaseView
    template: template

    initialize: () ->
      super()
      @listenTo(@model, 'change:currentPage.id', @render)
