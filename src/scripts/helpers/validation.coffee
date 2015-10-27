define (require) ->
  _ = require('underscore')
  Backbone = require('backbone')

  return new class ValidationHelper

    validateRequiredFields: () ->
      requiredFields = $('[required]')

      _.each requiredFields, (requiredField) ->
        required = $(requiredField)
        requiredParent = required.parents('.form-group')
        requiredLabel = required.closest('label').text()
        if required.val() is '' and !requiredParent.hasClass('has-error')
          requiredParent.addClass('has-error')
          required.next('.alert').addClass('alert-danger').text("#{requiredLabel} cannot be empty").show()

      if requiredFields.parents('.form-group').hasClass('has-error')
        return false

      return true

    checkForValidity: (e) ->
      current = $(e.currentTarget)

      if current.val() isnt '' and current.parents('.form-group').hasClass('has-error')
        current.parents('.form-group').removeClass('has-error')
        current.next('.alert').text('').removeClass('alert-danger').hide()
