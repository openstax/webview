define (require) ->
  PopoverView = require('cs!helpers/backbone/views/popover')
  template = require('hbs!./mail-template')
  require('less!./mail')

  return class MailPopoverView extends PopoverView
    popover:
      options:
        html: true
        placement: 'bottom'
        content: template()

      events:
        'submit form': (e) ->
          e.preventDefault()
          console.log('submitted')
