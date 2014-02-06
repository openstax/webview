define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')

  observerConfig =
    subtree: true
    childList: true
    characterData: true

  return class EditableView extends BaseView
    initialize: () ->
      super()

      @listenTo(@model, 'change:edit', @toggleEdit)

      @observer = new MutationObserver (mutations) =>
        mutations.forEach (mutation) =>
          page = @model.get('currentPage')

          @model.set('changed', true)
          page.set('changed', true)

    toggleEdit: () ->
      edit = @model.get('edit')
      $editable = @$el.children(@editable)

      $editable.attr('contenteditable', edit)

      if edit
        $editable.each (index) =>
          @observer.observe($editable.get(index), observerConfig)
      else
        @observer.disconnect()
