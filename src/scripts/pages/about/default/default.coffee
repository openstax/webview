define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./default-template')
  require('less!./default')

  return class AboutDefaultView extends BaseView
    template: template
