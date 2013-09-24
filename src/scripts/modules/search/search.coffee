define (require) ->
  SearchResults = require('cs!models/search-results')
  BaseView = require('cs!helpers/backbone/views/base')
  AdvancedSearchView = require('cs!./advanced/advanced')
  SearchResultsView = require('cs!./results/results')
  template = require('hbs!./search-template')
  require('less!./search')

  return class SearchView extends BaseView
    template: template

    initialize: () ->
      super()

      if location.search and location.search isnt '?q='
        @results = new SearchResults({query: location.search})

    regions:
      search: '.search'

    onRender: () ->
      if @results
        @regions.search.show(new SearchResultsView({results: @results}))
      else
        @regions.search.show(new AdvancedSearchView())
