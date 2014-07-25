define (require) ->
  FooterTabView = require('cs!../inherits/tab/tab')
  template = require('hbs!./history-template')
  require('less!./history')

  return class HistoryView extends FooterTabView
    template: template
    templateHelpers:
      uuid: () -> @model.getUuid()
