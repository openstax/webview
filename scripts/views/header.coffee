define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/inherits/base'
  'hbs!templates/header'
  'less!styles/header'
], ($, _, Backbone, BaseView, template) ->

  return class HeaderView extends BaseView
    # el is set by views/app.coffee
    # el: '#header'

    render: () ->
      @$el.html(template)
      return @
