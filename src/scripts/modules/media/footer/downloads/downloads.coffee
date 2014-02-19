define (require) ->
  FooterTabView = require('cs!../inherits/tab/tab')
  template = require('hbs!./downloads-template')
  require('less!./downloads')

  return class DownloadsView extends FooterTabView
    template: template

    initialize: () ->
      super()
      @listenTo(@model, 'change:downloads change:currentPage.downloads', @render)
