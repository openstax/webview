define (require) ->
  EditableView = require('cs!helpers/backbone/views/editable')

  return class FooterTabView extends EditableView
    templateHelpers: () ->
      @media ?= 'book'
      page = @model.asPage()
      model = page?.toJSON()
      model.type = @model.get('mediaType')

      return model or {}

    events:
      'click > .book-page-toggle > .btn:not(.active)': 'toggleMedia'

    initialize: () ->
      super()
      @listenTo(@model, 'change:currentPage', @render)

    toggleMedia: (e) ->
      @media = $(e.currentTarget).data('media')
      @render()
