define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./header-template')
  require('less!./header')

  return class SearchHeaderView extends BaseView
    template: template

    initialize: () ->
      super()
      @model?.attributes.results.criteria = window.location.search.replace('q=', 'criteria=')
      @listenTo(@model, 'change:results change:loaded', @render) if @model
