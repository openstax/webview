define [
  'jquery'
  'underscore'
  'backbone'
  'cs!helpers/backbone/views/base'
  'hbs!./header-template'
  'less!./header'
], ($, _, Backbone, BaseView, template) ->

  return class MediaHeaderView extends BaseView
    template: template()
