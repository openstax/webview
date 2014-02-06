define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./header-template')
  require('less!./header')
  require('bootstrapDropdown')

  return class SearchHeaderView extends BaseView
    template: template

    initialize: () ->
      super()
      @listenTo(@model, 'change:results change:loaded', @render) if @model
