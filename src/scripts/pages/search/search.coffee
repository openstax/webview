define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  HeaderView = require('cs!modules/header/header')
  FooterView = require('cs!modules/footer/footer')
  FindContentView = require('cs!modules/find-content/find-content')
  SearchResultsView = require('cs!modules/search-results/search-results')
  AdvancedSearchView = require('cs!modules/advanced-search/advanced-search')
  template = require('hbs!./search-template')
  require('less!./search')

  return class SearchPage extends BaseView
    template: template

    initialize: () ->
      super()

    regions:
      search: '#search'

    onRender: () ->
      @parent?.regions.header.show(new HeaderView({page: 'search'}))
      @parent?.regions.footer.show(new FooterView({page: 'search'}))
      @regions.search.show(new FindContentView())

      if location.search
        @regions.search.append(new SearchResultsView({query: location.search}))
      else
        @regions.search.append(new AdvancedSearchView())
