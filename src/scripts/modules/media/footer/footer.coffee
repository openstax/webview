define [
  'cs!helpers/backbone/views/base'
  'hbs!./footer-template'
  'less!./footer'
], (BaseView, template) ->

  return class MediaFooterView extends BaseView
    template: template()
