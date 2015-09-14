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
      'click .btn-ok': 'ok'
      'keydown': 'keyAction'

    keyAction: (event) ->
      if event.keyCode == 13
        event.preventDefault()
        event.stopPropagation()
        @$el.find('.btn-ok').click()

    promptForValue: (initialValue, @onOk) =>
      @$el.find('input').val(initialValue if initialValue isnt 'Untitled')
      @$el.modal('show')

    ok: () =>
      value = @$el.find('input').val()
      @$el.one('hidden.bs.modal', () => @onOk(value))
      @$el.modal('hide')
