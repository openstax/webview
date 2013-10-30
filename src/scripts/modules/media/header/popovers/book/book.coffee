define (require) ->
  PopoverView = require('cs!helpers/backbone/views/popover')
  template = require('hbs!./book-template')
  require('less!./book')

  return class BookPopoverView extends PopoverView
    popover:
      options:
        html: true
        placement: 'bottom'
        content: template
          model: @model
