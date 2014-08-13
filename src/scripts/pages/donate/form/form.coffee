define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./form-template')
  require('less!./form')

  return class DonateFormView extends BaseView
    template: template
