define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  HeaderView = require('cs!modules/header/header')
  FooterView = require('cs!modules/footer/footer')
  FindContentView = require('cs!modules/find-content/find-content')
  template = require('hbs!./about-us-template')
  require('less!./about-us')

  return class AboutUsPage extends BaseView
    template: template

    initialize: () ->
      super()

    onRender: () ->
      @parent.regions.header.show(new HeaderView({page: 'search', url: 'content/search'}))
      @parent.regions.footer.show(new FooterView({page: 'search'}))
