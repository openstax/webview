define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./footer-template')
  require('less!./footer')

  return class FooterView extends BaseView
    template: template()

    render: () ->
      super()

      height = @$el.find('.copyright').height()
      @$el.find('.connect').height(height)
      @$el.find('.share').height(height)
