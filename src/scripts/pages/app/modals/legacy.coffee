define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./legacy-template')
  require('less!./legacy')
  require('bootstrapTransition')
  require('bootstrapModal')

  return class LegacyModal extends BaseView
    template: template

    events:
      'submit': 'onSubmit'
      'shown.bs.modal': 'setFocus'

    setFocus: (e) ->
      $el = @$el
      $goButton = $el.find('button[type="submit"]')
      $goButton.focus()

    onSubmit: (e) ->
      e.preventDefault()

      if $(e.currentTarget).find('.checkbox input').is(':checked')
        document.cookie = "legacy=nowarn; max-age=#{60*60*24*30*365*4}; path=/;"

      location.href = @$el.children().data('href') # HACK to pass href value to modal view
