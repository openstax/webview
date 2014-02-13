define (require) ->
  EditableView = require('cs!helpers/backbone/views/editable')

  return class FooterTabView extends EditableView
    templateHelpers: () ->
      if @media is 'book'
        model = @model.toJSON()
      else
        @media = 'page'
        model = @model.get('currentPage')?.toJSON()

      return {media: @media, model: model}

    events:
      'click > .book-page-toggle > .btn:not(.active)': 'toggleMedia'

    initialize: () ->
      super()
      @listenTo(@model, 'changePage', @render)

    toggleMedia: (e) ->
      @media = $(e.currentTarget).data('media')
      @render()
