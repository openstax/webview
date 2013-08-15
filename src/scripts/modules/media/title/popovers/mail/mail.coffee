define [
  'cs!helpers/backbone/views/base'
  'cs!modules/popover/popover'
  'hbs!./mail-template'
  'less!./mail'
], (BaseView, PopoverView, template) ->

  return class MailPopoverView extends BaseView
    template: template()

    initialize: (options) ->
      @popover = new PopoverView
        owner: options.owner
        options:
          html: true
          placement: 'bottom'
          content: @template
        events:
          'submit form': (e) ->
            e.preventDefault()
            console.log('submitted')

    render: () -> return @

    submitForm: (e) ->
      e.preventDefault()

      alert('submitted!')

    close: () ->
      @popover.close()
      @popover = null
      super()
