define [
  'jquery'
  'underscore'
  'backbone'
  'cs!helpers/backbone/views/base'
  'hbs!./nav-template'
  'less!./nav'
], ($, _, Backbone, BaseView, template) ->

  return class MediaNavView extends BaseView
    template: template()
