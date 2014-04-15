define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./editbar-template')
  require('less!./editbar')
  require('bootstrapButton')
  require('bootstrapCollapse')

  return class EditbarView extends BaseView
    template: template
    templateHelpers:
      changed: () -> @model.get('changed') or @model.get('childChanged')

    events:
      'click .save':    'save'
      'click .revert':  'revert'

    initialize: () ->
      super()
      @listenTo(@model, 'change:changed change:childChanged', @render)

    save: () ->
      @model.save()

    revert: () ->
      model = @model # `@model` is cleared when editable is set to false
      model.set('editable', false)
      model.fetch()
