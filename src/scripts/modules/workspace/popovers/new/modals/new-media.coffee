define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  Content  = require('cs!models/content')
  Page = require('cs!models/contents/page')
  template = require('hbs!./new-media-template')
  validation = require('cs!helpers/validation.coffee')
  require('less!./new-media')
  require('bootstrapModal')

  return class NewMediaModal extends BaseView
    template: template

    events:
      'submit form': 'validate'

    onRender: () ->
      @$el.off('shown.bs.modal') # Prevent duplicating event listeners
      @$el.on 'shown.bs.modal', () => @$el.find('.new-title').focus()

    newContent: (options = {}) ->
      if options.type is 'Book'
        content = new Content
          mediaType: 'application/vnd.org.cnx.collection'
          title: options.title
          contents: []
      else
        content = new Page
          title: options.title

      content.save()
      .done () => @model.get('searchResults').prependNew(content)

    validate: (e) ->
      e.preventDefault()
      el = @$el
      input = el.find('input[type="text"]')
      alert = el.find('.alert')

      validation.validateModalTitle(e, input, alert, @onSubmit(), el)

    onSubmit: () ->
      @newContent
        title: @$el.find('.new-title').val()
        type: @model.get('type')

    show: () ->
      @render()
      @$el.modal('show').find('.alert').addClass('hidden')
