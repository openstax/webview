define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./processing-instructions-template')
  require('less!./processing-instructions')

  return class ProcessingInstructionsModel extends BaseView
    template: template

    events:
      'submit form': 'prependProcessingInstructions'

    prependProcessingInstructions: (e) ->
      e.preventDefault()
      mediaBody = $('.media-body')
      processingInstructions = mediaBody.find('cnx-pi')

      if processingInstructions.length
        processingInstructions.remove()

      mediaBody.prepend($('#pi').val())
      Aloha.trigger('aloha-smart-content-changed')
      $('#processing-instructions-modal').modal('hide')
