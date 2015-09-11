define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  BaseView = require('cs!helpers/backbone/views/base')
  require('bootstrapModal')
  template = require('hbs!./section-name-template')

  return class AddPageModal extends BaseView
    template: template
    onRender: () ->
      triggers = []
      @$el.on 'show.bs.modal', () =>
        @$el.find('input').val(@initialValue)
        triggers.push @$el.find('.btn-ok').on('click', @ok)
        triggers.push $('body').keydown((event) =>
          if event.keyCode == 13
            event.preventDefault()
            event.stopPropagation()
            @ok()
        )
      @$el.on 'hide.bs.modal', () =>
        trigger.off() for trigger in triggers
    initialValue: 'replace me'
    onOk: () ->
    ok: () =>
      value = @$el.find('input').val()
      @$el.modal('hide').one('hidden.bs.modal', () => @onOk(value))
