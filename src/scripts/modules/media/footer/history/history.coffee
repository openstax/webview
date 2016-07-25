define (require) ->
  FooterTabView = require('cs!../inherits/tab/tab')
  template = require('hbs!./history-template')
  require('less!./history')

  return class HistoryView extends FooterTabView
    template: template
    templateHelpers: () ->
        model = super()
        #@media = $(e.currentTarget).data('media')
        pageButton = @$el.find('[data-media="page"]').hasClass('active')
        console.debug("pagebutton", pageButton)
        console.debug("print this")

        if pageButton # and @model.isBook
          console.debug("here")
          currentPage = @model.get('currentPage')
          console.debug("current page", currentPage)
          model.uuid = currentPage.getUuid()
          console.debug("model.uuid", model.uuid)
        else
          console.debug("not page button")
          model.uuid = @model.getUuid()

        return model
