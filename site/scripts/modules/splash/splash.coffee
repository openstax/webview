define [
  'jquery'
  'underscore'
  'backbone'
  'cs!helpers/backbone/views/base'
  'hbs!./splash-template'
  'less!./splash'
  'bootstrapCarousel'
], ($, _, Backbone, BaseView, template) ->

    return class SplashView extends BaseView
      template: template()

      render: () ->
        super()

        # Initialize the Bootstrap Carousel
        $('.carousel').carousel().carousel('next')

        return @
