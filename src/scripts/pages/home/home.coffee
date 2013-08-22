define [
  'cs!helpers/backbone/views/base'
  'cs!modules/header/header'
  'cs!modules/footer/footer'
  'cs!modules/splash/splash'
  'cs!modules/find-content/find-content'
  'cs!modules/featured-books/featured-books'
  'hbs!./home-template'
  'less!./home'
], (BaseView, HeaderView, FooterView, SplashView, FindContentView, FeaturedBooksView, template) ->

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
