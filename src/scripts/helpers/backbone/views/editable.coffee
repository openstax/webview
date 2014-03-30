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

          setChanged = (model, onEdit) =>
            model.set('changed', true)
            model.set('currentPage.changed', true) if /^currentPage\./.test(value)
            onEdit.apply(@) if typeof onEdit is 'function'

          options.onBeforeEditable?($editable)

          switch options.type
            when 'textinput'
              $input = $('<input type="text" />')
              $input.attr('placeholder', "Enter a #{value} here").val(@model.get(value))
              $editable.html($input)
              $input.on 'change', () =>
                @model.set(value, $input.val())
                setChanged(@model, options.onEdit)

            # Setup contenteditable
            when 'contenteditable'
              $editable.attr('contenteditable', true)

              $editable.each (index) =>
                if @observers[selector] then @observers[selector].disconnect()

                @observers[selector] = new MutationObserver (mutations) =>
                  mutations.forEach (mutation) =>
                    @model.set(value, $($editable.get(index)).html())
                    setChanged(@model, options.onEdit)

                @observers[selector].observe($editable.get(index), options.config or observerConfig)

            # Setup Aloha
            when 'aloha'
              $editable.text('Loading editor...')
              require ['aloha', 'less!styles/aloha-hacks'], (Aloha) =>
                $editable.text('Starting up Aloha...')
                # Wait for Aloha to start up
                Aloha.ready () =>
                  $editable.html(@model.get(value) or '')
                  $editable.addClass('aloha-root-editable') # the semanticblockplugin needs this for some reason
                  $editable.aloha()

                  # Update the model if an event for this editable was triggered
                  Aloha.bind 'aloha-smart-content-changed.updatemodel', (evt, d) =>
                    if d.editable.obj.is($editable) or $.contains($editable[0], d.editable.obj[0])
                      @model.set(value, d.editable.getContents().trim()) # Trim for idempotence
                      setChanged(@model, options.onEdit)

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
                  @model.set(value, $editable.select2('val'))
                  setChanged(@model, options.onEdit)

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
              $editable.mahalo()

            when 'select2'
              $editable.off 'change.editable'

          options.onUneditable?($editable)

      @onUneditable()
