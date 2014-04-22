define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')
  PublishedListSectionView = require('cs!./list/section')
  template = require('hbs!./publish-template')
  require('less!./publish')
  require('bootstrapTransition')
  require('bootstrapModal')

  return class PublishModal extends BaseView
    template: template

    regions:
      contents: '.publish-list'

    events:
      'submit form': 'onSubmit'

    initialize: () ->
      super()

      @listenTo(@model, 'removeNode moveNode add:contents', @render)

    onRender: () ->
      @regions.contents.show(new PublishedListSectionView({model: @model}))

    onSubmit: (e) ->
      e.preventDefault()

      data = $(e.originalEvent.target).serializeArray()

      $('.modal-backdrop').remove() # HACK: Ensure bootstrap modal backdrop is removed
