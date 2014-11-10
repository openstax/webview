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
      'change .collection-checkbox': 'toggleBook'
      'change .publish-contents input': 'togglePage'
      'keyup textarea.required' : 'validate'
      'change input[type="checkbox"].required, input[type="checkbox"].collection-checkbox, input[type="checkbox"].page-checkbox' : 'validate'

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
        if field.name not in ['license', 'submitlog']
          items.push(field.name)

      submitlog = @$el.find('[name="submitlog"]').val()

      data = {submitlog, items}

      $.ajax
        type: 'POST'
        url: PUBLISHING
        data: JSON.stringify(data)
        dataType: 'json'
        xhrFields:
          withCredentials: true
      .done () =>
        # Close editor
        @model.set('editable', false)

        # Redirect to workspace
        router.navigate('workspace', {trigger: true})

      $('#publish-modal').hide() # Close the modal
      $('.modal-backdrop').remove() # HACK: Ensure bootstrap modal backdrop is removed

    toggleBook: (e) ->
      if $(e.currentTarget).is(':checked')
        # Ensure everything else is checked
        @$el.find('.publish-contents').find('input').prop('checked', true)

    togglePage: (e) ->
      if not $(e.currentTarget).is(':checked')
        # Uncheck the book
        @$el.find('.collection-checkbox').prop('checked', false)

    validate: () ->
      requiredTextBox = @$el.find('textarea.required').val()
      submitBtn = @$el.find('.btn-submit')
      requiredCheckboxes = @$el.find('.required:checked')
      pageCheckbox = @$el.find('.page-checkbox:checked')
      collectionCheckbox = @$el.find('.collection-checkbox:checked')

      if (requiredCheckboxes.length > 0 and requiredTextBox.length > 0) and pageCheckbox.length > 0 or collectionCheckbox.length > 0
        submitBtn.removeAttr('disabled')
      else
        submitBtn.prop('disabled',true)
