define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')
  FooterView = require('cs!modules/footer/footer')
  template = require('hbs!./main-page-template')

  return class MainPageView extends BaseView
    template: template
    regions:
      main: '.main-content'
      footer: '.footer'

    onRender: ->
      @regions.footer.show(new FooterView())
      @$el.addClass('main-page')
