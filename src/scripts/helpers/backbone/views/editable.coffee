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

    _toggleEditable: () ->
      if @model.get('editable')
        @_makeEditable()
      else
        @_makeUneditable()

    _makeEditable: () ->
      @onBeforeEditable()

      if @editable
        _.each @editable, (options, selector) =>
          $editable = @$el.find(selector)

          switch options.type
            when 'contenteditable' then $editable.attr('contenteditable', true)
            when 'aloha' then console.log 'FIX: enable aloha'

          options.onEditable?()
          $editable.each (index) =>
            if @observers[selector] then @observers[selector].disconnect()

            @observers[selector] = new MutationObserver (mutations) =>
              mutations.forEach (mutation) =>
                page = @model.get('currentPage')

                @model.set('changed', true)
                page.set('changed', true) if /^currentPage\./.test(options.value)

                @model.set(options.value, $($editable.get(index)).html())

            @observers[selector].observe($editable.get(index), options.config or observerConfig)

      @onEditable()

    _makeUneditable: () ->
      @onBeforeUneditable()

      if @editable
        _.each @editable, (options, selector) =>
          $editable = @$el.find(selector)

          switch options.type
            when 'contenteditable' then $editable.attr('contenteditable', false)
            when 'aloha' then console.log 'FIX: disable aloha'

          options.onUneditable?()
          @observers[selector].disconnect()
          delete @observers[selector]

      @onUneditable()
