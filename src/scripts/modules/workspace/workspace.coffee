define (require) ->
  router = require('cs!router')
  session  = require('cs!session')
  searchResults = require('cs!models/search-results')
  BaseView = require('cs!helpers/backbone/views/base')
  WorkspaceResultsView = require('cs!./results/results')
  Content  = require('cs!models/content')
  Page = require('cs!models/contents/page')
  template = require('hbs!./workspace-template')
  require('bootstrapDropdown')
  require('less!./workspace')

  WORKSPACE_URI = "#{location.origin}/users/contents"

  return class SearchView extends BaseView
    template: template

    events:
      'click .add-book': 'addBook'
      'click .add-page': 'addPage'

    regions:
      workspace: '.workspace'

    templateHelpers: () ->
      return {userId: session.get('id')}

    initialize: () ->
      super()

      @model = searchResults.load("?q=authorID:#{session.get('id')}", WORKSPACE_URI)

      @listenTo(@model, 'change:error', @displayError)
      @listenTo(@model, 'change:results change:loaded', @render) if @model


    onRender: () ->
      @regions.workspace.show(new WorkspaceResultsView({model: @model}))

    displayError: () ->
      error = arguments[1] # @model.get('error')
      router.appView.render('error', {code: error}) if error


    addBook: () ->
      title = prompt('What is the title for the new Book?')
      if title
        newBook = new Content
          mediaType: 'application/vnd.org.cnx.collection'
          title: title
          contents: []

        newBook.save()
        .fail(() -> alert('There was a problem saving. Please try again'))
        .done () => @model.prependNew(newBook)

    addPage: () ->
      title = prompt('What is the title for the new Page?')
      if title
        newPage = new Page
          title: title
          content: '<p>Please change this new Page</p>'

        newPage.save()
        .fail(() -> alert('There was a problem saving. Please try again'))
        .done () => @model.prependNew(newPage)
