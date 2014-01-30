define (require) ->
  $ = require('jquery')
  Mathjax = require('mathjax')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./body-template')
  require('less!./body')

  return class MediaBodyView extends BaseView
    template: template

    events:
      'click .solution > .ui-toggle-wrapper > .ui-toggle': 'toggleSolution'

    initialize: () ->
      super()
      @listenTo(@model, 'changePage', @render)
      @listenTo(@model, 'change:edit', @toggleEdit)

      @observer = new MutationObserver (mutations) =>
        mutations.forEach (mutation) =>
          page = @model.get('currentPage')

          @model.set('changed', true)
          page.set('changed', true)

    onRender: () ->
      MathJax.Hub.Queue(['Typeset', MathJax.Hub], @$el.get(0))

    toggleSolution: (e) ->
      $solution = $(e.currentTarget).closest('.solution')
      $solution.toggleClass('ui-solution-visible')

    toggleEdit: () ->
      edit = @model.get('edit')
      $mediaBody = @$el.children('.media-body')

      $mediaBody.attr('contenteditable', edit)

      if edit
        config =
          subtree: true
          childList: true
          characterData: true

        @observer.observe($mediaBody.get(0), config)
      else
        @observer.disconnect()
