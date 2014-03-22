define (require) ->
  Popover = require('cs!popover')
  AddPageModal = require('cs!./modals/add-page')
  template = require('hbs!./add-template')
  require('less!./add')
  require('bootstrapModal')

  return class AddPopoverView extends Popover
    template: template
    placement: 'bottom'

    events:
      'click .add-page': 'addPage'
      'click .add-section': 'addSection'
    
    onRender: () ->
      super()
      @parent?.regions.self.append(new AddPageModal({model: @model}))

    addSection: () ->
      @model.add
        contents: [],
        title: "Untitled"

    addPage: () ->
      $('#add-page-modal').modal()
