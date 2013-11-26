define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  HeaderView = require('cs!modules/header/header')
  FooterView = require('cs!modules/footer/footer')
  FindContentView = require('cs!modules/find-content/find-content')
  template = require('hbs!./404-template')
  require('less!./404')

  return class FourOhFourPage extends BaseView
    template: template
    pageTitle: 'Page Not Found'

    regions:
      find: '#find-content'

    onRender: () ->
      @parent.regions.header.show(new HeaderView({page: '404'}))
      @parent.regions.footer.show(new FooterView({page: '404'}))

      @regions.find.show(new FindContentView())
