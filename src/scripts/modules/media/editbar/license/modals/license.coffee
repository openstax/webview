define (require) ->
  settings = require('settings')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./license-template')

  authoringport = if settings.cnxauthoring.port then ":#{settings.cnxauthoring.port}" else ''
  PUBLISHING = "#{location.protocol}//#{settings.cnxauthoring.host}#{authoringport}/publish"

  return class LicenseView extends BaseView
    template: template

    events: {
      'submit form': 'onSubmit'
    }

    onSubmit: (e) ->
      e.preventDefault()
      $('#license-modal').hide()
      #$.ajax
        #type: 'POST'
        #url: PUBLISHING
        #data: ''
        #dataType: 'json'
      #.done () ->
      #  $('#license-modal').hide()
