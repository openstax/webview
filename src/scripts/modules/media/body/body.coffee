define [
  'cs!helpers/backbone/views/base'
  'hbs!./body-template'
  'less!./body'
], (BaseView, template) ->

  return class MediaBodyView extends BaseView
    template: template()
