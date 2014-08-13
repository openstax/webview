define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./default-template')
  require('less!./default')

  return class DonateDefaultView extends BaseView
    template: template
