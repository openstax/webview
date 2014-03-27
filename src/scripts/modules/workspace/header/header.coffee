define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./header-template')
  Content  = require('cs!models/content')
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
      alert('TODO: Not quite implemented yet.')
      # title = prompt('What is the title for the new Book?')
      # if title
      #   newBook = new Content
      #     title: title
      #     contents: []

      #   newBook.save()
      #   .fail(() -> alert('There was a problem saving. Please try again'))
      #   .done () => @model.prependNew(newBook)

    addPage: () ->
      title = prompt('What is the title for the new Page?')
      if title
        newPage = new Content
          title: title
          content: '<p>Please change this new Page</p>'

        newPage.save()
        .fail(() -> alert('There was a problem saving. Please try again'))
        .done () => @model.prependNew(newPage)
