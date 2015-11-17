define (require) ->
  linksHelper = require('cs!helpers/links')
  BaseView = require('cs!helpers/backbone/views/base')
  MainPageView = require('cs!modules/main-page/main-page')
  SearchView = require('cs!modules/search/search')

  MinimalSearchView = require('cs!modules/minimal/search/search')

  template = require('hbs!./search-template')
  require('less!./search')

  class InnerView extends BaseView
    template: template

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
        @regions.search.append(new MinimalSearchView())
      else
        @regions.search.append(new SearchView())

  return class SearchPage extends MainPageView
    canonical: null
    summary: 'Search for textbooks'
    description: 'Search from thousands of free, online textbooks.'

    initialize: (@options) ->
      super()

    onRender: ->
      super()
      @regions.main.show(new InnerView(@options))
