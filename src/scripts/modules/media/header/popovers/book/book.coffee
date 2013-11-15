define (require) ->
  Popover = require('cs!popover')
  template = require('hbs!./book-template')
  require('less!./book')

  return class BookPopoverView extends Popover
    template: template
    placement: 'bottom'
