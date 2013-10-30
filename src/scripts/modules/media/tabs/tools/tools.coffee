define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./tools-template')
  require('less!./tools')

  return class ToolsView extends BaseView
    template: template
    templateHelpers:
      encodedTitle: () -> encodeURI(@model.get('title'))
