define [
  'cs!helpers/backbone/views/base'
  'hbs!./footer-template'
  'less!./footer'
], (BaseView, template) ->

  return class MediaFooterView extends BaseView
    initialize: (options) ->
      super()
      @template = template options.content.toJSON()
