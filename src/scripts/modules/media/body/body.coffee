define [
  'cs!helpers/backbone/views/base'
  'hbs!./body-template'
  'less!./body'
], ($, _, Backbone, BaseView, template) ->

  return class MediaBodyView extends BaseView
    template: template()
