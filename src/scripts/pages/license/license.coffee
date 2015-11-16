define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  MainPageView = require('cs!modules/main-page/main-page')
  template = require('hbs!./license-template')
  require('less!./license')

  class InnerView extends BaseView
    template: template

  return class LicensePage extends MainPageView
    pageTitle: 'License FAQ - OpenStax CNX'
    canonical: null
    summary: 'OpenStax CNX License'
    description: 'OpenStax CNX License Frequently Asked Questions'

    onRender: ->
      super()
      @regions.main.show(new InnerView(@options))
