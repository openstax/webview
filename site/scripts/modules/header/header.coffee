define [
  'jquery'
  'underscore'
  'backbone'
  'cs!helpers/backbone/views/base'
  'hbs!./header-template'
  'less!./header'
], ($, _, Backbone, BaseView, template) ->

  return class HeaderView extends BaseView
    template: template()
