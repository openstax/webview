define (require) ->
  $ = require('jquery')

  return new class Validation

    validateModalTitle: (e, input, alert, onSubmit, el) ->
      e.preventDefault()
      if input.val() is ''
        alert.html('Title is required').removeClass('hidden')
      else
        alert.addClass('hidden')
        onSubmit
        el.modal('hide')
