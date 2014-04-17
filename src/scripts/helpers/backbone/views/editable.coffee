define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  # Dist HACK:
  # `styles/` puts us in `dist/scripts/styles`
  # `../styles` puts us in `dist/scripts/helpers/backbone/styles`
  # `../../../../styles` is JUUUSST RIGHT (not too hot and not too cold)
  require('less!../../../../styles/aloha-hacks')
  BaseView = require('cs!helpers/backbone/views/base')

  observerConfig =
    subtree: true
    childList: true
    characterData: true

  return class EditableView extends BaseView
    initialize: () ->
      super()
      @observers = {}

      @listenTo(@model, 'change:editable', @_toggleEditable)
      # Cannot makeUneditable `change:currentPage` because this event
      # is fired even when `changeCurrentPage.title` changes
      # @listenTo(@model, 'change:currentPage', @_makeUneditable)

    onAfterRender: () ->
      # Make editable after rendering if editable flag is already set
      @_makeEditable() if @isEditable()

    onBeforeEditable: () -> # noop
    onBeforeUneditable: () -> # noop
    onEditable: () -> # noop
    onUneditable: () -> # noop

    getModel: (value) ->
      if @model.isBook() then return "currentPage.#{value}" else return value

    # Override this method to change the logic for determining
    # whether or not the inherited view should be in edit mode.
    isEditable: () -> @model.isEditable()

    _toggleEditable: () ->
      if @isEditable()
        @_makeEditable()
      else
        @_makeUneditable()

    _makeEditable: () ->
      @onBeforeEditable()

      if @editable
        _.each @editable, (options = {}, selector) =>
          $editable = @$el.find(selector)

          if typeof options.value is 'function'
            attributeName = options.value.apply(@)
          else
            attributeName = options.value


          # do not rely on `currentPage.` when setting the value because
          # the currentPage may have changed in the meantime
          if /^currentPage\./.test(attributeName)
            myModel = @model.asPage()
            attributeName = attributeName.replace(/^currentPage\./, '')
            isCurrentPage = true
          else
            myModel = @model
            isCurrentPage = false

          getValue = () ->
            myModel.get(attributeName)

          setValue = (value) =>
            return if getValue() is value

            myModel.set(attributeName, value)
            myModel.set('changed', true)
            @model.set('childChanged', true) if isCurrentPage

            # Changing a module's title also change's a book's ToC
            if isCurrentPage and attributeName is 'title'
              @model.set('changed', true)

            options.onEdit.apply(@) if typeof options.onEdit is 'function'


          options.onBeforeEditable?($editable)

          switch options.type
            when 'textinput'
              $input = $('<input type="text" />')
              $input.attr('placeholder', "Enter a #{attributeName} here").val(getValue())
              $editable.html($input)
              $input.on 'change', () =>
                setValue($input.val())

            # Setup contenteditable
            when 'contenteditable'
              $editable.attr('contenteditable', true)

              $editable.each (index) =>
                if @observers[selector] then @observers[selector].disconnect()

                @observers[selector] = new MutationObserver (mutations) =>
                  mutations.forEach (mutation) =>
                    setValue($($editable.get(index)).html())

                @observers[selector].observe($editable.get(index), options.config or observerConfig)

            # Setup Aloha
            when 'aloha'
              $editable.mahalo?() # clicking Back/Next does not call mahalo so do it here
              $editable.text('Loading editor...')
              require ['aloha'], (Aloha) =>
                # Create a new id for it so back/next do not cause
                # the HTML from another page to get saved accidentally
                $editable.attr('id', GENTICS.Utils.guid())
                $editable.text('Starting up Aloha...')
                # Wait for Aloha to start up
                Aloha.ready () =>
                  html = getValue() or ''
                  html += "<p> </p>" # Allow putting cursor after a Blockish. removed if empty.
                  $editable.html(html)
                  $editable.addClass('aloha-root-editable') # the semanticblockplugin needs this for some reason
                  $editable.aloha()

                  # Grab the editable so we can call `.getContents()`
                  alohaId = $editable.attr('id')
                  alohaEditable = Aloha.getEditableById(alohaId)

                  if attributeName is 'content'
                    # See aloha.coffee for where this is used
                    window.GLOBAL_UPLOADER_HACK = () =>
                      editableBody = alohaEditable.getContents()
                      setValue(editableBody)

                  # Update the model if an event for this editable was triggered
                  Aloha.bind 'aloha-smart-content-changed.updatemodel', (evt, d) =>
                    isItThisEditable = d.editable.obj.is($editable)
                    isItThisEditable = isItThisEditable or $.contains($editable[0], d.editable.obj[0])

                    # If you're having blur problems I feel bad for you son: d.triggerType != 'blur'
                    if isItThisEditable

                      # Update the model by retrieving the XHTML contents
                      editableBody = alohaEditable.getContents()
                      editableBody = editableBody.trim() # Trim for idempotence
                      # Change the contents but do not update the Aloha editable area
                      setValue(editableBody)

            # Setup Select2
            when 'select2'
              require ['select2'], (select2) =>
                if typeof options.select2 is 'function'
                  s2 = options.select2.apply(@)
                else
                  s2 = options.select2 or {}

                $editable.select2(s2)

                $editable.off 'change.editable'
                $editable.on 'change.editable', (e) =>
                  setValue($editable.select2('val'))

          options.onEditable?($editable)

      @onEditable()

    _makeUneditable: () ->
      @onBeforeUneditable()

      if @editable
        _.each @editable, (options, selector) =>
          $editable = @$el.find(selector)

          if typeof options.value is 'function'
            value = options.value.apply(@)
          else
            value = options.value

          options.onBeforeUneditable?($editable)

          switch options.type
            when 'textinput'
              $editable.text(@model.get(value))

            when 'contenteditable'
              $editable.attr('contenteditable', false)
              @observers[selector].disconnect()
              delete @observers[selector]

            when 'aloha'
              $editable.mahalo?()

            when 'select2'
              $editable.off 'change.editable'

          options.onUneditable?($editable)

      @onUneditable()
