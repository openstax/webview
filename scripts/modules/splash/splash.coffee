define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/base'
  'hbs!./splash-template'
  'less!./splash'
  'bootstrapCarousel'
], ($, _, Backbone, BaseView, template) ->

    return class SplashView extends BaseView
      template: template()

      render: () ->
        @$el.html(@template)

        # Initialize the Bootstrap Carousel
        $('.carousel').carousel().carousel('next')

        return @
