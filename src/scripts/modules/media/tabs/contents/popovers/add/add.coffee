define (require) ->
  Popover = require('cs!popover')
  template = require('hbs!./add-template')
  require('less!./add')
  require('bootstrapModal')

  return class AddPopoverView extends Popover
    template: template
    placement: 'bottom'

    events:
      'click .add-page': 'addPage'
      'click .add-section': 'addSection'

    addSection: () ->
      @model.add
        contents: [],
        title: "Untitled"

    addPage: () ->
      console.log 'FIX: add page'
