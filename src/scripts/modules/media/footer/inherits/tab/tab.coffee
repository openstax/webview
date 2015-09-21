define (require) ->
  EditableView = require('cs!helpers/backbone/views/editable')

  return class FooterTabView extends EditableView
    templateHelpers: () ->
      @media ?= 'book'
      if @media is 'page'
        model = @model.asPage()
      else
        model = @model
      model = model?.toJSON() or {}
      model.type = @model.get('mediaType')

      return model or {}

    events:
      'click > .book-page-toggle > .btn:not(.active)': 'toggleMedia'
      'click > .book-page-toggle > .btn.active': 'stayHere'
      'click .content-display-button': 'contentDisplay'

    initialize: () ->
      super()
      @listenTo(@model, 'change:currentPage change:loaded change:currentPage.loaded', @render)

    stayHere: (e) ->
      false

    toggleMedia: (e) ->
      @media = $(e.currentTarget).data('media')
      @render()
      # Find the re-rendered element and apply focus
      @$el.find('.book-page-toggle .btn.active').focus()
      false

    contentDisplay: (e) ->
      e.preventDefault()
      currentTarget = $(e.currentTarget)
      contentDisplay = $('.content-display')
      contentDisplay.toggle()
      if contentDisplay.is(':visible')
        currentTarget.text('Less Details')
      else
        currentTarget.text('More Details')
      return
