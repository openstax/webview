define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./history-template')
  require('less!./history')

  return class HistoryView extends BaseView
    template: template

    initialize: () ->
      super()
      @listenTo(@model, 'changePage', @render)
