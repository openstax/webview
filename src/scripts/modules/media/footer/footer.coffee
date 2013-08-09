define [
  'jquery'
  'underscore'
  'backbone'
  'cs!helpers/backbone/views/base'
  'hbs!./footer-template'
  'less!./footer'
], ($, _, Backbone, BaseView, template) ->

  return class MediaFooterView extends BaseView
    template: template()
