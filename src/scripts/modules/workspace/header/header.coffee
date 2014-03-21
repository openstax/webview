define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./header-template')
  Collection  = require('cs!models/contents/collection')
  Page        = require('cs!models/contents/page')
  require('less!./header')
  require('bootstrapDropdown')

  return class WorkspaceHeaderView extends BaseView
    template: template

    events:
      'click .add-book': 'addBook'
      'click .add-page': 'addPage'

    initialize: () ->
      super()
      @listenTo(@model, 'change:results change:loaded', @render) if @model

    addBook: () ->
      title = prompt('What is the title for the new Book?')
      if title
        newBook = new Collection
          title: title
          contents: []
          parent: @model # Set so DnD works

        newBook.save()
        # TODO: update the workspace list after save completed
        # @model.add(newBook)

    addPage: () ->
      title = prompt('What is the title for the new Page?')
      if title
        newPage = new Page
          title: title
          content: '<p>Please change this new Page</p>'

        newPage.save()
        # TODO: update the workspace list after save completed
        # @model.add(newPage)
