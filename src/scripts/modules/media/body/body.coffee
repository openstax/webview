define [
  'cs!helpers/backbone/views/base'
  'hbs!./body-template'
  'less!./body'
], (BaseView, template) ->

  return class MediaBodyView extends BaseView
    template: () -> template @content.get('currentPage').toJSON()

    initialize: (options) ->
      super()
      @content = options.content

      @listenTo(@content.get('currentPage'), 'all', @render)

    render: () ->
      super()
