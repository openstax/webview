define (require) ->
  FooterTabView = require('cs!../inherits/tab/tab')
  template = require('hbs!./attribution-template')
  require('less!./attribution')

  return class AttributionView extends FooterTabView
    template: template

    initialize: () ->
      super()
      @listenTo(@model, 'change:licenseCode', @render)
