define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./downloads-template')
  require('less!./downloads')

  return class DownloadsView extends BaseView
    template: template

    initialize: () ->
      super()
      @listenTo(@model, 'changePage', @render)
