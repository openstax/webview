define (require) ->
  Popover = require('cs!popover')
  template = require('hbs!./book-template')
  analytics = require('cs!helpers/handlers/analytics')
  require('less!./book')

  return class BookPopoverView extends Popover
    template: template
    templateHelpers:
      currentPage: () ->
        return @model.asPage()
      isIpad: navigator.userAgent.match(/iPad/i) != null
    events:
      'click [data-ipad="true"]': (e) ->
        window.location.href = e.target.href
      'click [data-format="PDF"]': (e) ->
        analytics.sendDownloadAnalytics(@model.get('googleAnalytics'),@model.attributes.title, 'PDF', \
        @model.attributes.downloads[0].path)
      'click [data-format="EPUB"]': (e) ->
        analytics.sendDownloadAnalytics(@model.get('googleAnalytics'),@model.attributes.title, 'EPUB', \
        @model.attributes.downloads[1].path)
      'click [data-format="Offline ZIP"]': (e) ->
        analytics.sendDownloadAnalytics(@model.get('googleAnalytics'),@model.attributes.title, 'Offline Zip', \
        @model.attributes.downloads[2].path)

    placement: 'bottom'

    initialize: () ->
      super(arguments...)
      @listenTo(@model, 'change:currentPage change:downloads change:currentPage.downloads', @render)
