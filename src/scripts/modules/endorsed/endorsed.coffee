define [
  'jquery'
  'underscore'
  'backbone'
  'cs!helpers/backbone/views/base'
  'hbs!./endorsed-template'
  'less!./endorsed'
], ($, _, Backbone, BaseView, template) ->

  return class EndorsedView extends BaseView
    template: template()
