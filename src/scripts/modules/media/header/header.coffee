define [
  'cs!helpers/backbone/views/base'
  'hbs!./header-template'
  'less!./header'
], (BaseView, template) ->

  return class MediaHeaderView extends BaseView
    template: template()
