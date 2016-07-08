define (require) ->
  MainPageView = require('cs!modules/main-page/main-page')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./tos-template')
  require('less!./tos')

  class InnerView extends BaseView
    template: template

  return class TosPage extends MainPageView
    pageTitle: 'terms-of-service-pageTitle'
    canonical: null
    summary: 'terms-of-service-summary'
    description: 'terms-of-service-description'

    onRender: ->
      super()
      @regions.main.show(new InnerView())
