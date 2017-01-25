define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  MediaComponentView = require('cs!helpers/backbone/views/media-component')

  setValue = (property, value, options = {}) ->
    if @getProperty(property) is value then return

    model = @getModel()

    if not model then return

    value = options.setValue?.call(@, property, value, options) or value

    model.set(property, value, {doNotRerender:true})
    model.set('changed', true, {doNotRerender:true})

    if model.isInBook()
      @model.set('childChanged', true, {doNotRerender:true})

      # Changing a page's title also change's a book's ToC
      if property is 'title'
        @model.set('changed', true, {doNotRerender:true})

    options.onEdit.apply(@) if typeof options.onEdit is 'function'

  # Each type of editable has a start and stop for enabling/disabling the editable
  editables =
    'textinput':
      stop: ($editable, selector, property, options) ->
        $editable.text(@getProperty(property))
      start: ($editable, selector, property, options) ->
        $input = $('<input type="text" />')
        $input.attr('placeholder', "Enter a #{property}").val(@getProperty(property))
        $editable.html($input)
        $input.on 'change', () => setValue.call(@, property, $input.val(), options)


    'contenteditable':
      stop: ($editable, selector, property, options) ->
        $editable.attr('contenteditable', false)
        @observers[selector].disconnect()
        delete @observers[selector]
      start: ($editable, selector, property, options) ->
        observerConfig =
          subtree: true
          childList: true
          characterData: true

        @observers ?= {}

        $editable.attr('contenteditable', true)

        $editable.each (index) =>
          if @observers[selector] then @observers[selector].disconnect()

          @observers[selector] = new MutationObserver (mutations) =>
            mutations.forEach (mutation) =>
              setValue.call(@, property, $editable.eq(index).html(), options)

          @observers[selector].observe($editable.get(index), options.config or observerConfig)


    'select2':
      stop: ($editable, selector, property, options) ->
        $editable.off 'change.editable'
      start: ($editable, selector, property, options) ->
        require ['select2'], (select2) =>
          if typeof options.select2 is 'function'
            s2 = options.select2.apply(@)
          else
            s2 = options.select2 or {}

          $editable.select2(s2)

          $editable.off 'change.editable'
          $editable.on 'change.editable', (e) =>
            setValue.call(@, property, $editable.select2('val'), options)


    'aloha':
      stop: ($editable, selector, property, options) ->
        $editable.mahalo?()
      start: ($editable, selector, property, options) ->
        $editable.mahalo?() # clicking Back/Next does not call mahalo so do it here
        $editable.text('Loading editor...')
        require ['aloha'], (Aloha) =>
          # Create a new id for it so back/next do not cause
          # the HTML from another page to get saved accidentally
          $editable.attr('id', GENTICS.Utils.guid())
          $editable.text('Starting up Aloha...')
          # Wait for Aloha to start up
          Aloha.ready () =>
            html = @getProperty(property) or ''

            if $editable.hasClass('draft') and $editable.last() isnt $('<p></p>')
              html += '<p></p>' # Allow putting cursor after a Blockish. removed if empty.

            $editable.html(html)
            $editable.addClass('aloha-root-editable') # the semanticblockplugin needs this for some reason
            # Unwrap <section> elements into h# elements
            # There are 3 cases:
            # 1. <section><h#>
            # 2. <section><h?> (wrong heading number)
            # 3. <section><no-heading>
            #
            # For 1-2 the solution is to always replace the <h#> with the correct heading.
            # For 3, just add a dummy title (or unwrap the section (eep!)
            $sections = $editable.find('section')
            $headings = $()

            $sections.each (i, el) ->
              $section = $(el)
              $firstChild = $section.children(':first-child')
              level = $section.parentsUntil($editable, 'section').length + 1
              $newHeading = $("<h#{level}></h#{level}>")
              $newHeading.attr('id', $section.attr('id'))
              $newHeading.attr('class', $section.attr('class'))

              $headings = $headings.add($newHeading)

              if $firstChild.is('h1,h2,h3,h4,h5,h6')
                $newHeading.append($firstChild.contents() or 'Dummy Title')
                $firstChild.replaceWith($newHeading)
              else
                $section.prepend($newHeading)

            $headings.unwrap()

            $editable.aloha()

            # Grab the editable so we can call `.getContents()`
            alohaId = $editable.attr('id')
            alohaEditable = Aloha.getEditableById(alohaId)

            if property is 'content'
              # See aloha.coffee for where this is used
              window.GLOBAL_UPLOADER_HACK = () =>
                editableBody = alohaEditable.getContents()
                setValue.call(@, property, editableBody, options)

            # Update the model if an event for this editable was triggered
            Aloha.bind 'aloha-smart-content-changed.updatemodel', (evt, d) =>
              # Ensures that all unwrapped text is wrapped in p tags
              $('.media-body').contents().filter(-> @nodeType is 3).wrap '<p></p>'
              # HACK - d is undefined because processing instructions
              # needs to trigger aloha-smart-content-change event
              if d is undefined or d.triggerType isnt 'blur'
                # Update the model by retrieving the XHTML contents
                editableBody = alohaEditable.getContents()
                editableBody = editableBody.trim() # Trim for idempotence
                # Change the contents but do not update the Aloha editable area
                setValue.call(@, property, editableBody, options)


  return class EditableView extends MediaComponentView
    _editable: false

    initialize: () ->
      console.info('this is an editable')
      super()

      @listenTo(@model, 'change:editable', @_toggleEditable)
      # Cannot makeUneditable `change:currentPage` because this event
      # is fired even when `changeCurrentPage.title` changes
      # @listenTo(@model, 'change:currentPage', @_makeUneditable)

      # When remote changes happen then disable editing
      # @listenTo @model, 'change:changed-remotely', (model, val, options) ->
      #  if val
      #    @_makeUneditable()

    onAfterRender: () ->
      if @media is 'page'
        editable = if @model.isBook() then @model.get('currentPage')?.isEditable() else @model.isEditable()
      else
        editable = @model.isEditable()

      # Make editable after rendering if editable flag is already set
      @_makeEditable(true) if editable

    onBeforeEditable: () -> # noop
    onBeforeUneditable: () -> # noop
    onEditable: () -> # noop
    onUneditable: () -> # noop

    _toggleEditable: () ->
      if @model.get('loaded')
        if @model.asPage()?.get('version') isnt 'draft'
          editable = false
        else
          editable = @model.isEditable()

      # Only toggle the editable state if it really changed
      if editable is @_editable then return

      @_makeEditable(editable)

    _getProperty: (value) ->
      if typeof value is 'function'
        return value.apply(@)

      return value

    _makeEditable: (enabled) ->
      @_editable = enabled

      if enabled then @onBeforeEditable() else @onBeforeUneditable()

      if @editable
        _.each @editable, (options = {}, selector) =>
          $editable = @$el.find(selector)
          property = @_getProperty(options.value)

          if options.type
            config = editables[options.type] or throw new Error('ERROR: Unsupported editable type')
          else
            config = options

          if enabled
            options.onBeforeEditable?($editable)
            config.start.call(@, $editable, selector, property, options)
            options.onEditable?($editable)
          else
            options.onBeforeUneditable?($editable)
            config.stop.call(@, $editable, selector, property, options)
            options.onUneditable?($editable)

      if enabled then @onEditable() else @onUneditable()
