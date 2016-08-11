define (require) ->
  $ = require('jquery')
  router = require('cs!router')
  BaseView = require('cs!helpers/backbone/views/base')
  SliderView = require('cs!../donation-slider/donation-slider')
  template = require('hbs!./default-template')
  require('less!./default')

  return class DonateDefaultView extends BaseView
    template: template

    regions:
      slider: '.slider'

    onRender: () ->
      @regions.slider.show(new SliderView())