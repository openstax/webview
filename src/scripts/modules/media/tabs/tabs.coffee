define [
  'cs!helpers/backbone/views/base'
  'hbs!./tabs-template'
  'less!./tabs'
], (BaseView, template) ->

  return class MediaTabsView extends BaseView
    template: template()
