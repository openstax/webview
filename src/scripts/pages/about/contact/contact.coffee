define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./contact-template')
  require('less!./contact')

  return class AboutContactView extends BaseView
    template: template
