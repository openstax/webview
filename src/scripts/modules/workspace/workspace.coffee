define (require) ->
  router = require('cs!router')
  searchResults = require('cs!models/search-results')
  BaseView = require('cs!helpers/backbone/views/base')
  WorkspaceResultsView = require('cs!./results/results')
  template = require('hbs!./workspace-template')
  require('less!./workspace')

  return class SearchView extends BaseView
    template: template

    initialize: () ->
      super()

      @model = searchResults.load('?q=author:"OpenStax%20College"')

      @listenTo(@model, 'change:error', @displayError)

    regions:
      workspace: '.workspace'

    onRender: () ->
      @regions.workspace.show(new WorkspaceResultsView({model: @model}))

    displayError: () ->
      error = arguments[1] # @model.get('error')
      router.appView.render('error', {code: error}) if error
