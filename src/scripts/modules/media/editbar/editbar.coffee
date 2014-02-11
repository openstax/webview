define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./editbar-template')
  require('less!./editbar')
  require('bootstrapButton')

  return class EditbarView extends BaseView
    template: template
