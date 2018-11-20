define (require) ->
  FooterTabView = require('cs!../inherits/tab/tab')
  template = require('hbs!./downloads-template')
  analytics = require('cs!helpers/handlers/analytics')
  require('less!./downloads')

  return class DownloadsView extends FooterTabView
    template: template

    events:
      'click [data-format="PDF"]': (e) ->
        analytics.sendDownloadAnalytics(@model.get('googleAnalytics'),@model.attributes.title, 'PDF', @model.attributes.downloads[0].path)
      'click [data-format="EPUB"]': (e) ->
        analytics.sendDownloadAnalytics(@model.get('googleAnalytics'),@model.attributes.title, 'EPUB', @model.attributes.downloads[1].path)
      'click [data-format="Offline ZIP"]': (e) ->
        analytics.sendDownloadAnalytics(@model.get('googleAnalytics'),@model.attributes.title, 'Offline Zip', @model.attributes.downloads[2].path)

    initialize: () ->
      super()
      @listenTo(@model, 'change:downloads change:currentPage.downloads', @render)
