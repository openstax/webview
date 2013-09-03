define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  HeaderView = require('cs!modules/header/header')
  FooterView = require('cs!modules/footer/footer')
  SplashView = require('cs!modules/splash/splash')
  FindContentView = require('cs!modules/find-content/find-content')
  FeaturedBooksView = require('cs!modules/featured-books/featured-books')
  template = require('hbs!./home-template')
  require('less!./home')

  return class HomeView extends BaseView
    template: template()

    regions:
      splash: '#splash'
      find: '#find-content'
      featured: '#featured-books'
      #news: '#news'
      #spotlight: '#spotlight'

    render: () ->
      super()

      @parent?.regions.header.show(new HeaderView({page: 'home'}))
      @parent?.regions.footer.show(new FooterView({page: 'home'}))

      @regions.splash.show(new SplashView())
      @regions.featured.show(new FeaturedBooksView())
      @regions.find.show(new FindContentView())
      #@regions.news.show(new NewsView())
      #@regions.spotlight.show(new SpotlightView())

      return @
