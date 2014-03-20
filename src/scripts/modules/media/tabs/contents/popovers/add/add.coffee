define (require) ->
  # Page = require('cs!models/contents/page')
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

    # from http://stackoverflow.com/a/8809472
    generateUUID: () ->
      d = new Date().getTime()
      uuid = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g, (c) ->
        r = (d + Math.random() * 16) % 16 | 0
        d = Math.floor(d / 16)
        ((if c is "x" then r else (r & 0x7 | 0x8))).toString 16
      )
      return uuid

    addSection: () ->
      @model.add
        contents: [],
        title: "Untitled"

    addPage: () ->
      title = prompt('What is the title for the new Page?')
      if title
        uuid = @generateUUID()

        @model.add
          id: uuid
          title: title
          # a non-array contents makes this a `Page` instead of a `Subcollection`
          contents: '<p>Please change this new Page</p>'

        # TODO: For some reason I cannot create a `new Page({...})` and add it.
        # TODO: POST the new page so the click to the new page will eventually resolve
