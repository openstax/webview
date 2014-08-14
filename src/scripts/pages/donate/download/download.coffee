define (require) ->
  $ = require('jquery')
  router = require('cs!router')
  Content = require('cs!models/content')
  BaseView = require('cs!helpers/backbone/views/base')
  SliderView = require('cs!../donation-slider/donation-slider')
  template = require('hbs!./download-template')
  require('less!./download')

  return class DonateDownloadView extends BaseView
    template: template
    templateHelpers:
      path: () -> _.find(@model.get('downloads'), (download) -> download.format is 'PDF')?.path

    regions:
      slider: '.slider'

    initialize: (options = {}) ->
      super()

      # Allow downloads after they've visited the donation page
      # Cookie expires after 30 days
      document.cookie = "donation=requested; max-age=#{60*60*24*30}; path=/;"

      @uuid = options.uuid
      @type = options.type or 'pdf'
      @model = options.model or new Content({id: @uuid})

      @listenTo(@model, 'change:downloads', @render)

    onRender: () ->
      @regions.slider.show new SliderView
        uuid: @uuid
        type: @type
