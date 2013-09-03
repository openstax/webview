define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./tabs-template')
  require('less!./tabs')

  return class MediaTabsView extends BaseView
    initialize: (options) ->
      super()
      @template = template options.content.toJSON()
