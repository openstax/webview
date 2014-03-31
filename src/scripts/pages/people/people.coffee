define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  HeaderView = require('cs!modules/header/header')
  FooterView = require('cs!modules/footer/footer')
  FindContentView = require('cs!modules/find-content/find-content')
  template = require('hbs!./people-template')
  require('less!./people')

  return class AboutUsPage extends BaseView
    template: template

    onRender: () ->
      @parent.regions.header.show(new HeaderView({page: 'search', url: 'content/search'}))
      @parent.regions.footer.show(new FooterView({page: 'search'}))
