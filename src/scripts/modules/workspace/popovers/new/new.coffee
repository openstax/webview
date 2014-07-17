define (require) ->
  Popover = require('cs!popover')
  NewMediaModal = require('cs!./modals/new-media')
  template = require('hbs!./new-template')
  require('less!./new')

  return class NewPopoverView extends Popover
    template: template
    placement: 'bottom'

    events:
      'click .new-book': 'newBook'
      'click .new-page': 'newPage'
    
    initialize: () ->
      super(arguments...)
      @_modalModel = new Backbone.Model
        searchResults: @model
        type: 'Book'
      @mediaModal = new NewMediaModal({model: @_modalModel})

    onRender: () ->
      super()
      @parent?.regions.self.appendOnce
        view: @mediaModal
        as: 'div id="new-media-modal" class="modal fade"'

    newBook: (e) -> @newMedia(e, 'Book')
    newPage: (e) -> @newMedia(e, 'Page')

    newMedia: (e, type) ->
      @_modalModel.set('type', type)
      @hide(e) # Hide the popover
      @mediaModal.show()
