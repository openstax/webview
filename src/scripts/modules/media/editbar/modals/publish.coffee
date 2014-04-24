define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  settings = require('settings')
  router = require('cs!router')
  BaseView = require('cs!helpers/backbone/views/base')
  PublishedListSectionView = require('cs!./list/section')
  template = require('hbs!./publish-template')
  require('less!./publish')
  require('bootstrapTransition')
  require('bootstrapModal')

  PUBLISHING = "#{location.protocol}//#{settings.cnxauthoring.host}:#{settings.cnxauthoring.port}/publish"

  return class PublishModal extends BaseView
    template: template

    regions:
      contents: '.publish-contents'

    events:
      'submit form': 'onSubmit'
      'change [name="license"]': 'onToggleAcceptLicense'

    initialize: () ->
      super()

      @listenTo(@model, 'removeNode moveNode add:contents', @render)

    onRender: () ->
      @regions.contents.show(new PublishedListSectionView({model: @model}))

    onSubmit: (e) ->
      e.preventDefault()

      formData = $(e.originalEvent.target).serializeArray()
      data = []

      _.each formData, (field) ->
        if field.name isnt 'license'
          data.push(field.name)

      $.ajax
        type: 'POST'
        url: PUBLISHING
        data: JSON.stringify(data)
        dataType: 'json'
        xhrFields:
          withCredentials: true
      .done () ->
        # Close editor
        @model.set('editable', false)

        # Redirect to workspace
        router.navigate('workspace', {trigger: true})

      $('#publish-modal').hide() # Close the modal
      $('.modal-backdrop').remove() # HACK: Ensure bootstrap modal backdrop is removed

    onToggleAcceptLicense: (e) ->
      if $(e.currentTarget).is(':checked')
        @$el.find('.btn-submit').removeClass('disabled')
      else
        @$el.find('.btn-submit').addClass('disabled')
