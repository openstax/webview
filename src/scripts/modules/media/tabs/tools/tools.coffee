define (require) ->
  session = require('cs!session')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./tools-template')
  require('less!./tools')

  return class ToolsView extends BaseView
    template: template
    templateHelpers: () -> {
      authenticated: session.get('username')
      encodedTitle: encodeURI(@model.get('title'))
    }

    events:
      'click .edit, .preview': 'toggleEditor'

    initialize: () ->
      super()
      @listenTo(@model, 'change:editable change:title', @render)
      @listenTo(session, 'change', @render)

    toggleEditor: () ->
      @model.set('editable', not @model.get('editable'))
