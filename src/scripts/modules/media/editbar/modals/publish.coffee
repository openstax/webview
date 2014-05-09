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
      'change .collection-checkbox': 'toggleBook'
      'change .publish-contents input': 'togglePage'

    initialize: () ->
      super()

      @listenTo(@model, 'removeNode moveNode add:contents', @render)

    onRender: () ->
      @regions.contents.show(new PublishedListSectionView({model: @model}))

    onSubmit: (e) ->
      e.preventDefault()

      formData = $(e.originalEvent.target).serializeArray()
      items = []

      _.each formData, (field) ->
        if field.name isnt 'license'
          items.push(field.name)


      data =
        submitlog: 'TEST_SUBMITLOG'
        items: items


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

    toggleBook: (e) ->
      if $(e.currentTarget).is(':checked')
        # Ensure everything else is checked
        @$el.find('.publish-contents').find('input').prop('checked', true)

    togglePage: (e) ->
      if not $(e.currentTarget).is(':checked')
        # Uncheck the book
        @$el.find('.collection-checkbox').prop('checked', false)
