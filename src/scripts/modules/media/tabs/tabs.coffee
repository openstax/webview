define [
  'cs!helpers/backbone/views/base'
  'hbs!./tabs-template'
  'less!./tabs'
], (BaseView, template) ->

  return class MediaTabsView extends BaseView
    initialize: (options) ->
      super()
      @template = template options.content.toJSON()
