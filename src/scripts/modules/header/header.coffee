define [
  'jquery'
  'cs!helpers/backbone/views/base'
  'hbs!./header-template'
  'less!./header'
], ($, BaseView, template) ->

  return class HeaderView extends BaseView
    template: template

    initialize: (options) ->
      super()
      @page = options?.page

    render: () ->
      @$el.html @template
        page: @page

      return @
