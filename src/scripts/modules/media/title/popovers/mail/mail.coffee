define [
  'cs!helpers/backbone/views/popover'
  'hbs!./mail-template'
  'less!./mail'
], (PopoverView, template) ->

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
