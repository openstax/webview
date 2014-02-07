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

    onBeforeEditable: () -> # noop
    onEditable: () -> # noop

    _toggleEditable: () ->
      @onBeforeEditable()

      if @editable
        edit = @model.get('editable')

        _.each @editable, (options, selector) =>
          $editable = @$el.find(selector)

          switch options.type
            when 'contenteditable' then $editable.attr('contenteditable', edit)
            when 'aloha' then console.log 'FIX: enable aloha'

          if edit
            options.onEditable?()
            $editable.each (index) =>
              if @observers[selector] then @observers[selector].disconnect()

              @observers[selector] = new MutationObserver (mutations) =>
                mutations.forEach (mutation) =>
                  page = @model.get('currentPage')

                  @model.set('changed', true)
                  page.set('changed', true)

                  @model.set(options.value, $($editable.get(index)).html())

              @observers[selector].observe($editable.get(index), options.config or observerConfig)
          else
            options.onUneditable?()
            @observers[selector].disconnect()

      @onEditable()
