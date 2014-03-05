define (require) ->
  Popover = require('cs!popover')
  template = require('hbs!./add-template')
  require('less!./add')
  require('bootstrapModal')

  return class AddPopoverView extends Popover
    template: template
    placement: 'bottom'

    events:
      'click .add-module': 'addModule'
      'click .add-subcollection': 'addSubcollection'

    addSubcollection: () ->
      @model.get('contents').add
        contents: [],
        title: "Untitled"
      @model.trigger('add')

    addModule: () ->
      console.log 'add module'
