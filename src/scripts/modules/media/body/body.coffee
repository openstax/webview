define [
  'cs!helpers/backbone/views/base'
  'hbs!./body-template'
  'less!./body'
], (BaseView, template) ->

  return class MediaBodyView extends BaseView
    initialize: (options) ->
      super()
      @template = template options.content.get('currentPage').toJSON()
