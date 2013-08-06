define [
  'jquery'
  'underscore'
  'backbone'
  'cs!helpers/backbone/views/base'
  'hbs!./header-template'
  'less!./header'
], ($, _, Backbone, BaseView, template) ->

  return class HeaderView extends BaseView
    template: template

    initialize: (options) ->
      super()
      @page = options?.page

    render: () ->
      @$el.html @template
        page: @page

      return @
