define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./nav-template')
  require('less!./nav')

  return class MediaNavView extends BaseView
    initialize: (options) ->
      super()
      @content = options.content
      @hideProgress = options.hideProgress

      if not @hideProgress
        @listenTo(@content, 'change:page change:pages', @render)

    render: () ->
      tmplOptions = @content.toJSON()
      tmplOptions._hideProgress = @hideProgress
      @template = template tmplOptions
      super()

    events:
      'click .next': 'nextPage'
      'click .back': 'previousPage'

    nextPage: (e) ->
      @content.nextPage()

    previousPage: (e) ->
      @content.previousPage()
