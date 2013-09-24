define (require) ->
  SearchResults = require('cs!models/search-results')
  BaseView = require('cs!helpers/backbone/views/base')
  SearchHeaderView = require('cs!./header/header')
  SearchFilterView = require('cs!./filter/filter')
  SearchBreadcrumbsView = require('cs!./breadcrumbs/breadcrumbs')
  SearchResultsView = require('cs!./results/results')
  template = require('hbs!./search-template')
  require('less!./search')

  return class SearchView extends BaseView
    template: template

    initialize: (options) ->
      super()

      if not options or not options.query
        throw new Error('A search view must be instantiated with the search query to fetch')

      @results = new SearchResults({query: options.query})
      window.x = @results

    regions:
      header: '.header'
      filter: '.filter'
      breadcrumbs: '.breadcrumbs'
      results: '.results'

    onRender: () ->
      @regions.header.show(new SearchHeaderView({model: @results}))
      @regions.filter.show(new SearchFilterView({model: @results}))
      @regions.breadcrumbs.show(new SearchBreadcrumbsView({model: @results}))
      @regions.results.show(new SearchResultsView({model: @results}))
