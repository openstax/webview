define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  HeaderView = require('cs!modules/header/header')
  FooterView = require('cs!modules/footer/footer')
  FindContentView = require('cs!modules/find-content/find-content')
  template = require('hbs!./tos-template')
  require('less!./tos')

  return class TosPage extends BaseView
    template: template
    pageTitle: 'Terms of Service - OpenStax CNX'
    canonical: null
    summary: 'OpenStax CNX Terms of Service'
    description: 'OpenStax CNX Terms of Service'

    regions:
      find: '.find'

    onRender: () ->
      @parent.regions.header.show(new HeaderView({page: 'tos'}))
      @parent.regions.footer.show(new FooterView({page: 'tos'}))
      @regions.find.show(new FindContentView())
