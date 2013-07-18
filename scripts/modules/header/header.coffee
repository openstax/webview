define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/base'
  'hbs!templates/modules/header/header'
  'less!./header'
], ($, _, Backbone, BaseView, template) ->

  return class HeaderView extends BaseView
    template: template()

    render: () ->
      @$el.html(@template)
      return @
