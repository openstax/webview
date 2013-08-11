define [
  'jquery'
  'underscore'
  'backbone'
  'cs!helpers/backbone/views/base'
  'hbs!./tabs-template'
  'less!./tabs'
], ($, _, Backbone, BaseView, template) ->

  return class MediaTabsView extends BaseView
    template: template()
