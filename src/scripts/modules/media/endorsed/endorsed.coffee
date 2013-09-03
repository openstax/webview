define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./endorsed-template')
  require('less!./endorsed')

  return class EndorsedView extends BaseView
    initialize: (options) ->
      super()
      @template = template options.content.toJSON()
