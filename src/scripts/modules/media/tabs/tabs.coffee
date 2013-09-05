define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./tabs-template')
  require('less!./tabs')

  return class MediaTabsView extends BaseView
    template: template
