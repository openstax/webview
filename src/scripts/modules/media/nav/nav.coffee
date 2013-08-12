define [
  'cs!helpers/backbone/views/base'
  'hbs!./nav-template'
  'less!./nav'
], (BaseView, template) ->

  return class MediaNavView extends BaseView
    template: template()
