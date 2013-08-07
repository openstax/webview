define [
  'jquery'
  'underscore'
  'backbone'
  'cs!helpers/backbone/views/base'
  'hbs!./footer-template'
  'less!./footer'
], ($, _, Backbone, BaseView, template) ->

  return class FooterView extends BaseView
    template: template()
