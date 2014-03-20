define (require) ->
  Page = require('cs!models/contents/page')
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
      title = prompt('What is the title for the new Page?')
      if title
        newPage = new Page
          title: title
          content: '<p>Please change this new Page</p>'
          book: @model
          parent: @model # Set so DnD works

        # TODO: add the model **after** save completes
        # newPage.save()
        @model.add(newPage)
