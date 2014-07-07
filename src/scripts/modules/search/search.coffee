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

      search = _.filter window.location.search.slice(1).split('&'), (query) ->
        return query.substr(0,2) is 'q='

      if search[0] and search[0].length > 2
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
