define [
  'jquery'
  'underscore'
  'backbone'
  'cs!helpers/backbone/views/base'
  'hbs!./title-template'
  'less!./title'
], ($, _, Backbone, BaseView, template) ->

  return class MediaTitleView extends BaseView
    template: template()
