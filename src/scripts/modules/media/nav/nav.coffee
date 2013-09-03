define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./nav-template')
  require('less!./nav')

  return class MediaNavView extends BaseView
    initialize: (options) ->
      super()
      @hideProgress = options.hideProgress

      if not @hideProgress
        @listenTo(@model, 'change:page change:pages', @render)

    render: () ->
      tmplOptions = @model.toJSON()
      tmplOptions._hideProgress = @hideProgress
      @template = template tmplOptions
      super()

    events:
      'click .next': 'nextPage'
      'click .back': 'previousPage'

    nextPage: (e) ->
      @model.nextPage()

    previousPage: (e) ->
      @model.previousPage()
