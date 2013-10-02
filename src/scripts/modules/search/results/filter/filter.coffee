define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./filter-template')
  require('less!./filter')

  return class SearchResultsFilterView extends BaseView
    template: template

    initialize: () ->
      super()
      @listenTo(@model, 'change', @render) if @model
