define [
  'cs!helpers/backbone/views/base'
  'hbs!./nav-template'
  'less!./nav'
], (BaseView, template) ->

  return class MediaNavView extends BaseView
    initialize: (options) ->
      super()
      tmplOptions = options.content.toJSON()
      tmplOptions._hideProgress = options.hideProgress
      @template = template tmplOptions
