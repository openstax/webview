define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  PublishModal = require('cs!./modals/publish')
  template = require('hbs!./editbar-template')
  require('less!./editbar')
  require('bootstrapButton')
  require('bootstrapCollapse')
  require('bootstrapModal')

  return class EditbarView extends BaseView
    template: template
    templateHelpers:
      changed: () -> @model.get('changed') or @model.get('childChanged')

    events:
      'click .save':    'save'
      'click .revert':  'revert'
      'click .publish': 'publish'

    initialize: () ->
      super()
      @listenTo(@model, 'change:changed change:childChanged', @render)

    onRender: () ->
      super()
      @parent?.regions.self.append(new PublishModal({model: @model}))

    save: () ->
      @model.save()

    revert: () ->
      model = @model # `@model` is cleared when editable is set to false
      model.set('editable', false)
      model.fetch()

    publish: () ->
      $('#publish-modal').modal()
