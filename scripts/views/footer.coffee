define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/inherits/base'
  'hbs!templates/footer'
  'less!styles/footer'
], ($, _, Backbone, BaseView, template) ->

  return class FooterView extends BaseView
    # el is set by views/app.coffee
    # el: '#footer'

    render: () ->
      @$el.html(template)
      return @
