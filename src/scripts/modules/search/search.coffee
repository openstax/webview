define (require) ->
  router = require('cs!router')
  searchResults = require('cs!models/search-results')
  BaseView = require('cs!helpers/backbone/views/base')
  AdvancedSearchView = require('cs!./advanced/advanced')
  SearchResultsView = require('cs!./results/results')
  template = require('hbs!./search-template')
  require('less!./search')

  return class SearchView extends BaseView
    template: template
    pageTitle: 'Search'

    initialize: () ->
      super()

      if location.search and location.search isnt '?q='
        @model = searchResults.load({query: location.search})

      @listenTo(@model, 'change:error', @displayError) if @model

    regions:
      search: '.search'

    onRender: () ->
      if @model
        @regions.search.show(new SearchResultsView({model: @model}))
      else
        @regions.search.show(new AdvancedSearchView())

    displayError: () ->
      error = arguments[1] # @model.get('error')
      router.appView.render('error', {code: error}) if error
