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

    initialize: () ->
      super(arguments...)
      @addPageModal = new AddPageModal({model: @model})

    onRender: () ->
      super()
      @regions.self.appendOnce
        view: @addPageModal
        as: 'div id="add-page-modal" class="modal fade" aria-hidden="true"'

    addSection: (e) ->
      @hide(e)
      @model.add
        contents: [],
        title: "Untitled"

    addPage: (e) ->
      @hide(e)
      @addPageModal.$el.modal('show')

    onBeforeClose: () ->
      super()
      delete @addPageModal
