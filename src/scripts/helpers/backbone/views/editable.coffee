define (require) ->
  $ = require('jquery')
  _ = require('underscore')
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

    onAfterRender: () ->
      # Make editable after rendering if editable flag is already set
      @_makeEditable() if @model.get('editable')

    onBeforeEditable: () -> # noop
    onBeforeUneditable: () -> # noop
    onEditable: () -> # noop
    onUneditable: () -> # noop

    getModel: (value) ->
      if @model.isBook() then return "currentPage.#{value}" else return value

    _toggleEditable: () ->
      if @model.get('editable')
        @_makeEditable()
      else
        @_makeUneditable()

    _makeEditable: () ->
      @onBeforeEditable()

      if @editable
        _.each @editable, (options = {}, selector) =>
          $editable = @$el.find(selector)

          if typeof options.value is 'function'
            value = options.value.apply(@)
          else
            value = options.value

          setChanged = (onEdit) =>
            page = @model.get('currentPage')
            @model.set('changed', true)
            page.set('changed', true) if /^currentPage\./.test(value)
            onEdit.apply(@) if typeof onEdit is 'function'

          options.onBeforeEditable?($editable)

          switch options.type
            when 'textinput'
              $editable.empty()
              $input = jQuery('<input type="text"/>')
              $input.attr('placeholder', "Enter a #{value} here")
              $input.val(@model.get(value))
              $editable.append($input)
              $input.on 'change', () =>
                @model.set(value, $input.val())

            # Setup contenteditable
            when 'contenteditable'
              $editable.attr('contenteditable', true)

              $editable.each (index) =>
                if @observers[selector] then @observers[selector].disconnect()

                @observers[selector] = new MutationObserver (mutations) =>
                  mutations.forEach (mutation) =>
                    setChanged(options.onEdit)
                    @model.set(value, $($editable.get(index)).html())

                @observers[selector].observe($editable.get(index), options.config or observerConfig)

            # Setup Aloha
            when 'aloha'
              $editable.text('Loading editor...')
              require ['aloha', 'less!styles/aloha-hacks'], (Aloha) =>
                $editable.text('Starting up Aloha...')
                # Wait for Aloha to start up
                Aloha.ready () =>
                  $editable.text('Starting editor...')

                  # HACK: backbone-associations does not return the HTML for some reason
                  html = @model.get(value)
                  if not html?
                    temp = @model
                    for attr in value.split('.')
                      temp = temp.get(attr)
                    html = temp

                  if not html?
                    $editable.text('Problem starting editor')
                  else
                    $editable.html(html)
                    $editable.addClass('aloha-root-editable') # the semanticblockplugin needs this for some reason
                    $alohaEditable = Aloha.jQuery($editable)
                    $alohaEditable.aloha()

                    # Update the model if an event for this editable was triggered
                    Aloha.bind 'aloha-smart-content-changed.updatemodel', (evt, d) ->
                      updateModel() if d.triggerType != 'blur' and \
                        (d.editable.obj.is($alohaEditable) or $.contains($alohaEditable[0], d.editable.obj[0]))

                # Update the model by retrieving the XHTML contents
                updateModel = () =>
                  alohaId = $editable.attr('id')
                  alohaEditable = Aloha.getEditableById(alohaId)

                  if alohaEditable
                    editableBody = alohaEditable.getContents()
                    editableBody = editableBody.trim() # Trim for idempotence
                    # Change the contents but do not update the Aloha editable area
                    @model.set(value, editableBody) # TODO: Should we add a flag to not re-render the editable?
                    setChanged(options.onEdit)

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
                  setChanged(options.onEdit)
                  @model.set(value, $editable.select2('val'))

          options.onEditable?($editable)

      @onEditable()

    _makeUneditable: () ->
      @onBeforeUneditable()

      if @editable
        _.each @editable, (options, selector) =>
          $editable = @$el.find(selector)

          options.onBeforeUneditable?($editable)

          switch options.type
            when 'textinput'
              $editable.text(@model.get(value))

            when 'contenteditable'
              @observers[selector].disconnect()
              delete @observers[selector]

            when 'aloha'
              $HACK = Aloha.jQuery($editable[0])
              $HACK.mahalo()

            when 'select2'
              $editable.off 'change.editable'

          options.onUneditable?($editable)

      @onUneditable()
