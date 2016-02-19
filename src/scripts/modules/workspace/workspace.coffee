define (require) ->
  router = require('cs!router')
  session  = require('cs!session')
  searchResults = require('cs!models/search-results')
  BaseView = require('cs!helpers/backbone/views/base')
  WorkspaceResultsView = require('cs!./results/results')
  NewPopoverView = require('cs!./popovers/new/new')
  template = require('hbs!./workspace-template')
  require('less!./workspace')

  WORKSPACE_URI = "#{location.origin}/users/contents"

  return class WorkspaceView extends BaseView
    template: template
    templateHelpers: () ->
      return {userId: session.get('id')}

    regions:
      workspace: '.workspace'

    events:
      'click .reload.btn': 'reload'

    initialize: () ->
      super()

      @model = searchResults.config
        url: WORKSPACE_URI

      @listenTo(@model, 'change:error', @displayError)

    onRender: () ->
      @model.fetch() # Force update

      @regions.workspace.show(new WorkspaceResultsView({model: @model}))

      @regions.self.append new NewPopoverView
        model: @model
        owner: @$el.find('.new.btn')

    displayError: () ->
      error = arguments[1] # @model.get('error')
      router.appView.render('error', {code: error}) if error

    reload: () -> @model.fetch()
