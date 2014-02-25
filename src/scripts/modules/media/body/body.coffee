define (require) ->
  $ = require('jquery')
  Mathjax = require('mathjax')
  EditableView = require('cs!helpers/backbone/views/editable')
  template = require('hbs!./body-template')
  require('less!./body')

  return class MediaBodyView extends EditableView
    template: template
    templateHelpers:
      hasBody: () -> @model.get('contents')?.length or @model.get('currentPage')

    editable:
      '.media-body':
        value: 'currentPage.content'
        type: 'contenteditable'

    events:
      'click .solution > .ui-toggle-wrapper > .ui-toggle': 'toggleSolution'

    initialize: () ->
      super()
      @listenTo(@model, 'changePage', @render)

    onRender: () ->
      # MathJax.Hub.Queue(['Typeset', MathJax.Hub], @$el.get(0))

    toggleSolution: (e) ->
      $solution = $(e.currentTarget).closest('.solution')
      $solution.toggleClass('ui-solution-visible')
