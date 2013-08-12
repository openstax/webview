define [
  'cs!helpers/backbone/views/base'
  'hbs!./title-template'
  'less!./title'
], (BaseView, template) ->

  return class MediaTitleView extends BaseView
    template: template()
