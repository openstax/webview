define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./body-template')
  require('less!./body')

  return class MediaBodyView extends BaseView
    template: () -> template @model.get('currentPage').toJSON()

    initialize: () ->
      super()

      @listenTo(@model.get('currentPage'), 'all', @render)

    render: () ->
      super()
