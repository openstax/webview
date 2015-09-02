define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  HeaderView = require('cs!modules/header/header')
  FooterView = require('cs!modules/footer/footer')
  FindContentView = require('cs!modules/find-content/find-content')
  template = require('hbs!./license-template')
  require('less!./license')

  return class LicensePage extends BaseView
    template: template
    pageTitle: 'License FAQ - OpenStax CNX'
    canonical: null
    summary: 'OpenStax CNX License'
    description: 'OpenStax CNX License Frequently Asked Questions'

    regions:
      find: '.find'

    onRender: () ->
      @parent.regions.header.show(new HeaderView({page: 'license'}))
      @parent.regions.footer.show(new FooterView({page: 'license'}))
      @regions.find.show(new FindContentView())
