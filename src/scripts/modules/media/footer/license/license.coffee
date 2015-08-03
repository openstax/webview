define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./license-template')
  require('less!./license')

  return class LicenseView extends BaseView
    template: template

    initialize: () ->
      super()
      @listenTo(@model, 'reset change:currentPage change:licenseCode', @render)
