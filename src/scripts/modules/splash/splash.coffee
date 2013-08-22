define [
  'jquery'
  'cs!helpers/backbone/views/base'
  'hbs!./splash-template'
  'less!./splash'
  'bootstrapCarousel'
], ($, BaseView, template) ->

  return class SplashView extends BaseView
    template: template()

    render: () ->
      super()

      # Initialize the Bootstrap Carousel
      $('.carousel').carousel().carousel('next')

      return @
