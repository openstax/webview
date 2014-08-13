define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  Content = require('cs!models/content')
  template = require('hbs!./thankyou-template')
  require('less!./thankyou')

  # Trick to download a file with JavaScript
  downloadUrl = (url) ->
    hiddenIFrameId = 'hiddenDownloader'
    iframe = document.getElementById(hiddenIFrameId)
    if iframe is null
      iframe = document.createElement('iframe')
      iframe.id = hiddenIFrameId
      iframe.style.display = 'none'
      document.body.appendChild(iframe)

    iframe.src = url

  return class DonateThankYouView extends BaseView
    template: template
    templateHelpers:
      path: () -> @path

    downloaded: false

    initialize: (options = {}) ->
      super()

      @uuid = options.uuid
      @type = options.type or 'pdf'
      @model = options.model or new Content({id: @uuid})

      @listenTo(@model, 'change:downloads', @render)

    onBeforeRender: () ->
      @path = _.find(@model.get('downloads'), (download) -> download.format is 'PDF')?.path

    onAfterRender: () ->
      # Only attempt to download the file once
      if not @downloaded and @path
        @downloaded = true
        downloadUrl(@path)
