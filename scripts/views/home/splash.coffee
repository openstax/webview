define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/inherits/base'
  'hbs!templates/home/splash'
  'less!styles/home/splash'
  'bootstrapCarousel'
], ($, _, Backbone, BaseView, template) ->

    return class SplashView extends BaseView
      template: template()
      render: () ->
        @$el.html(@template)

        # Initialize the Bootstrap Carousel
        $('.carousel').carousel().carousel('next')

        return @
