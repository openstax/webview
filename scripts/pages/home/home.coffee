define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/base'
  'cs!modules/header/header'
  'cs!modules/footer/footer'
  'cs!modules/splash/splash'
  'cs!modules/featured-books/featured-books'
  'hbs!templates/pages/home/home'
  'less!./home'
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
