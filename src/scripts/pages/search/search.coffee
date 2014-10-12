define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  HeaderView = require('cs!modules/header/header')
  FooterView = require('cs!modules/footer/footer')
  FindContentView = require('cs!modules/find-content/find-content')
  SearchView = require('cs!modules/search/search')
  template = require('hbs!./search-template')
  require('less!./search')

  return class SearchPage extends BaseView
    template: template
    canonical: null
    summary: null

    initialize: () ->
      super()

    regions:
      search: '#search'

    onRender: () ->
      @parent.regions.header.show(new HeaderView({page: 'search', url: 'content/search'}))
      @parent.regions.footer.show(new FooterView({page: 'search'}))
      @regions.search.show(new FindContentView())
      @regions.search.append(new SearchView())
