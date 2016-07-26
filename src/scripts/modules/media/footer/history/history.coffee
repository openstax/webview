define (require) ->
  FooterTabView = require('cs!../inherits/tab/tab')
  template = require('hbs!./history-template')
  require('less!./history')

  return class HistoryView extends FooterTabView
    template: template
    templateHelpers: () ->
        model = super()

        if @media is 'page'
          currentPage = @model.get('currentPage')
          model.uuid = currentPage.getUuid()

        else
          model.uuid = @model.getUuid()

        return model
