define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./splash-template')
  require('less!./splash')
  require('bootstrapCarousel')

  return class SplashView extends BaseView
    template: template

    onRender: () ->
      # Initialize the Bootstrap Carousel
      $('.carousel').carousel().carousel('next')
