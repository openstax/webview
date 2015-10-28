define (require) ->
  linksHelper = require('cs!helpers/links')
  BaseView = require('cs!helpers/backbone/views/base')
  HeaderView = require('cs!modules/header/header')
  FooterView = require('cs!modules/footer/footer')
  FindContentView = require('cs!modules/find-content/find-content')
  SearchView = require('cs!modules/search/search')

  MinimalHeaderView = require('cs!modules/minimal/header/header')
  MinimalSearchView = require('cs!modules/minimal/search/search')

  template = require('hbs!./search-template')
  require('less!./search')

  return class SearchPage extends BaseView
    template: template
    canonical: null
    summary: 'Search for textbooks'
    description: 'Search from thousands of free, online textbooks.'

    initialize: (options) ->
      super()

      queryString = linksHelper.serializeQuery(location.search)
      @minimal = false
      if queryString.minimal
        @minimal = true

    regions:
      search: '#search'

    onRender: () ->
      if @minimal
        @parent.regions.header.show(new MinimalHeaderView({page: 'search', url: 'content/search'}))
        @parent.regions.footer.show(new FooterView({page: 'search'}))
        @regions.search.append(new MinimalSearchView())
      else
        @parent.regions.header.show(new HeaderView({page: 'search', url: 'content/search'}))
        @parent.regions.footer.show(new FooterView({page: 'search'}))
        @regions.search.show(new FindContentView())
        @regions.search.append(new SearchView())
