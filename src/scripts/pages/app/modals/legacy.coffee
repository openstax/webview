define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./legacy-template')
  require('less!./legacy')

  return class LegacyModal extends BaseView
    template: template

    events:
      'submit': 'onSubmit'

    onSubmit: (e) ->
      e.preventDefault()

      if $(e.currentTarget).find('.checkbox input').is(':checked')
        document.cookie = "legacy; max-age=#{60*60*24*30*365*4}; path=/;"

      location.href = @$el.children().data('href') # HACK to pass href value to modal view
