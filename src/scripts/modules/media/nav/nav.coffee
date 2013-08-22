define [
  'cs!helpers/backbone/views/base'
  'hbs!./nav-template'
  'less!./nav'
], (BaseView, template) ->

  return class MediaNavView extends BaseView
    template: template

    initialize: (options) ->
      super()
      @bottom = options?.bottom

    render: () ->
      @$el.html @template
        bottom: @bottom

      return @
