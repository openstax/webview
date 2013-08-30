define [
  'cs!helpers/backbone/views/popover'
  'hbs!./book-template'
  'less!./book'
], (PopoverView, template) ->

  return class BookPopoverView extends PopoverView
    popover:
      options:
        html: true
        placement: 'bottom'
        content: template()
