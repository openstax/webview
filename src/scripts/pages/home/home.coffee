define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  MainPageView = require('cs!modules/main-page/main-page')
  SplashView = require('cs!modules/splash/splash')
  FeaturedBooksView = require('cs!modules/featured-books/featured-books')
  template = require('hbs!./home-template')
  require('less!./home')

  class InnerView extends BaseView
    template: template

    regions:
      splash: '#splash'
      find: '#find-content'
      featured: '#featured-books'

    onRender: () ->
      @regions.splash.show(new SplashView())
      @regions.featured.show(new FeaturedBooksView())

  return class HomePage extends MainPageView
    pageTitle: 'Sharing Knowledge and Building Communities'
    canonical: null
    summary: 'View and share free educational material as courses, books,reports or other academic assignments.'
    description: 'Free, online educational material such as courses, books and reports.'

    onRender: ->
      super()
      @regions.main.show(new InnerView())
