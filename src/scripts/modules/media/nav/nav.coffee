define [
  'cs!helpers/backbone/views/base'
  'hbs!./nav-template'
  'less!./nav'
], (BaseView, template) ->

  return class MediaNavView extends BaseView
    initialize: (options) ->
      super()
      @content = options.content
      @hideProgress = options.hideProgress

      if not @hideProgress
        @listenTo(@content, 'change:currentPage', @render)

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
