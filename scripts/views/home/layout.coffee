define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/inherits/base'
  'cs!views/header'
  'cs!views/footer'
  'hbs!templates/home/layout'
  'less!styles/home/home'
  'bootstrapCarousel'
], ($, _, Backbone, BaseView, HeaderView, FooterView, template) ->

    return class HomeView extends BaseView
      regions:
        splash: '#splash'
        find: '#find'
        featured: '#featured'
        news: '#news'
        spotlight: '#spotlight'

      render: () ->
        @parent?.regions.header.show(new HeaderView())
        @parent?.regions.footer.show(new FooterView())

        @$el.html(template)

        #@regions.splash.show(new SplashView())
        #@regions.find.show(new FindView())
        #@regions.featured.show(new FeaturedView())
        #@regions.news.show(new NewsView())
        #@regions.spotlight.show(new SpotlightView())

        return @
