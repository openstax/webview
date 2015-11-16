define (require) ->
  MainPageView = require('cs!modules/main-page/main-page')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./tos-template')
  require('less!./tos')

  class InnerView extends BaseView
    template: template

  return class TosPage extends MainPageView
    pageTitle: 'Terms of Service - OpenStax CNX'
    canonical: null
    summary: 'OpenStax CNX Terms of Service'
    description: 'OpenStax CNX Terms of Service'

    onRender: ->
      super()
      @regions.main.show(new InnerView())
