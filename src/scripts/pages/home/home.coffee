define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  HeaderView = require('cs!modules/header/header')
  FooterView = require('cs!modules/footer/footer')
  SplashView = require('cs!modules/splash/splash')
  FindContentView = require('cs!modules/find-content/find-content')
  FeaturedBooksView = require('cs!modules/featured-books/featured-books')
  template = require('hbs!./home-template')
  require('less!./home')

  return class HomePage extends BaseView
    template: template
    pageTitle: 'Sharing Knowledge and Building Communities'
    canonical: null
    summary: 'OpenStax CNX'

    regions:
      splash: '#splash'
      find: '#find-content'
      featured: '#featured-books'
      #news: '#news'
      #spotlight: '#spotlight'

    onRender: () ->
      @parent.regions.header.show(new HeaderView({page: 'home', url: 'content'}))
      @parent.regions.footer.show(new FooterView({page: 'home'}))

      @regions.splash.show(new SplashView())
      @regions.featured.show(new FeaturedBooksView())
      @regions.find.show(new FindContentView())
      #@regions.news.show(new NewsView())
      #@regions.spotlight.show(new SpotlightView())
