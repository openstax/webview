define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  BaseView = require('cs!helpers/backbone/views/base')
  require('bootstrapModal')
  require('less!./section-name')
  template = require('hbs!./section-name-template')

  return class SectionNameModal extends BaseView
    template: template

    events:
      'submit': 'submit'

    submit: (event) =>
      event.preventDefault()
      event.stopPropagation()
      value = @$el.find('input').val()
      @$el.one('hidden.bs.modal', () => @onOk(value))
      @$el.modal('hide')

    promptForValue: (initialValue, @onOk) =>
      input = @$el.find('input')
      input.val(initialValue if initialValue isnt 'Untitled')
      @$el.modal('show')
      input.focus()
