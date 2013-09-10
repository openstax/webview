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

          $form = $(e.currentTarget)
          subject = @model.get('title')
          # from = $form.find('.js-email')
          to = $form.find('.js-target-email').val()
          message = $form.find('.js-message').val()

          document.location.href = "mailto:#{to}?subject=#{subject}&body=#{message}"
