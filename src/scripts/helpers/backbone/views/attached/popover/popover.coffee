define (require) ->
  Tooltip = require('cs!tooltip')
  template = require('hbs!helpers/backbone/views/attached/popover/popover-template')
  require('less!helpers/backbone/views/attached/popover/popover')

  return class Popover extends Tooltip
    containerTemplate: template
