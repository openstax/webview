define [
  'jquery'
  'underscore'
  'backbone'
  'cs!helpers/backbone/views/base'
  'hbs!./find-content-template'
  'less!./find-content'
  'bootstrapDropdown'
], ($, _, Backbone, BaseView, template) ->

  return class FindContentView extends BaseView
    template: template()
