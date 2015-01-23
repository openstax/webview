define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  Content  = require('cs!models/content')
  Page = require('cs!models/contents/page')
  template = require('hbs!./new-media-template')
  require('less!./new-media')
  require('bootstrapModal')
  router = require('cs!router')

  return class NewMediaModal extends BaseView
    template: template

    events:
      'submit form': 'onSubmit'

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
      .fail(() -> alert('There was a problem saving. Please try again'))
      .done () =>
        router.navigate("/contents/#{content.id}@draft", {trigger: true})

    onSubmit: (e) ->
      e.preventDefault()
      @newContent
        title: @$el.find('.new-title').val()
        type: @model.get('type')

      @$el.modal('hide')

    show: () ->
      @render()
      @$el.modal('show')
