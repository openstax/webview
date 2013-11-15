define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!helpers/backbone/views/attached/tooltip/tooltip-template')
  require('less!helpers/backbone/views/attached/tooltip/tooltip')

  return class Tooltip extends BaseView
    containerTemplate: template

    _renderDom: (data) ->
      @$el?.html @containerTemplate
        title: @title
        content: @template?(data) or @template
