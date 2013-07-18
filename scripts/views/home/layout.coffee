define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/inherits/base'
  'cs!views/header'
  'cs!views/footer'
  'cs!views/home/splash'
  'cs!views/shared/featured-books'
  'hbs!templates/home/layout'
  'less!styles/home/home'
], ($, _, Backbone, BaseView, HeaderView, FooterView, SplashView, FeaturedBooksView, template) ->

    return class HomeView extends BaseView
      template: template()
      regions:
        splash: '#splash'
        #find: '#find'
        featured: '#featured-books'
        #news: '#news'
        #spotlight: '#spotlight'

      render: () ->
        @parent?.regions.header.show(new HeaderView())
        @parent?.regions.footer.show(new FooterView())

        @$el.html(@template)

        @regions.splash.show(new SplashView())
        @regions.featured.show(new FeaturedBooksView())
        #@regions.find.show(new FindView())
        #@regions.news.show(new NewsView())
        #@regions.spotlight.show(new SpotlightView())

        return @
