define (require) ->
  Popover = require('cs!popover')
  template = require('hbs!./book-template')
  require('less!./book')

  return class BookPopoverView extends Popover
    template: template
    templateHelpers:
      currentPage: () ->
        if @model.isBook()
          return @model.get('currentPage')
        else
          return @model

    placement: 'bottom'

    initialize: () ->
      super(arguments...)
      @listenTo(@model, 'change:currentPage change:downloads change:currentPage.downloads', @render)
