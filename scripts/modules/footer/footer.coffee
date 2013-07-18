define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/base'
  'hbs!.footer-template'
  'less!./footer'
], ($, _, Backbone, BaseView, template) ->

  return class FooterView extends BaseView
    template: template()

    render: () ->
      @$el.html(@template)
      return @
