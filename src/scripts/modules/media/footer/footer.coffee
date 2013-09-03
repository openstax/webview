define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./footer-template')
  require('less!./footer')

  return class MediaFooterView extends BaseView
    initialize: () ->
      super()
      @template = template @model.toJSON()
