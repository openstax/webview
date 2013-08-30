define [
  'cs!helpers/backbone/views/base'
  'hbs!./endorsed-template'
  'less!./endorsed'
], (BaseView, template) ->

  return class EndorsedView extends BaseView
    initialize: (options) ->
      super()
      @template = template options.content.toJSON()
