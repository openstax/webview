define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./body-template')
  require('less!./body')

  return class MediaBodyView extends BaseView
    template: () -> template @content.get('currentPage').toJSON()

    initialize: (options) ->
      super()
      @content = options.content

      @listenTo(@content.get('currentPage'), 'all', @render)

    render: () ->
      super()
