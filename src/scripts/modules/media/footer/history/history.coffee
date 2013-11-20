define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./history-template')
  require('less!./history')

  return class HistoryView extends BaseView
    template: template
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
