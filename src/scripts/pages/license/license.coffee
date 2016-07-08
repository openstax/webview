define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  MainPageView = require('cs!modules/main-page/main-page')
  template = require('hbs!./license-template')
  require('less!./license')

  class InnerView extends BaseView
    template: template

  return class LicensePage extends MainPageView
    pageTitle: 'licensing-pageTitle'
    canonical: null
    summary: 'licensing-summary'
    description: 'licensing-description'

    onRender: ->
      super()
      @regions.main.show(new InnerView(@options))
