define (require) ->
  SearchResults = require('cs!models/search-results')
  BaseView = require('cs!helpers/backbone/views/base')
  SearchHeaderView = require('cs!./header/header')
  AdvancedSearchView = require('cs!./advanced/advanced')
  SearchResultsView = require('cs!./results/results')
  template = require('hbs!./search-template')
  require('less!./search')

  return class SearchView extends BaseView
    template: template

    initialize: () ->
      super()

      if location.search
        @results = new SearchResults({query: location.search})

    regions:
      search: '.search'

    onRender: () ->
      @regions.search.show(new SearchHeaderView({model: @results}))

      if @results
        @regions.search.append(new SearchResultsView({results: @results}))
      else
        @regions.search.append(new AdvancedSearchView())
