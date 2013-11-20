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

    onRender: () ->
      MathJax.Hub.Queue(['Typeset', MathJax.Hub], @$el.get(0))

    toggleSolution: (e) ->
      $solution = $(e.target).closest('.solution')
      $solution.toggleClass('ui-solution-visible')
