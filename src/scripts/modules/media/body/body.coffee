define (require) ->
  $ = require('jquery')
  Mathjax = require('mathjax')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./body-template')
  require('less!./body')

  return class MediaBodyView extends BaseView
    template: template

    initialize: () ->
      super()
      @listenTo(@model, 'changePage', @render)

    onRender: () ->
      MathJax.Hub.Queue(['Typeset', MathJax.Hub], @$el.get(0))

      # Add a "Show/Hide Solutions" button for all Exercise Solutions
      $solutions = @$el.find('.solution')
      $solutions.children().wrap('<div class="js-solution-wrapper"></div>').parent()
      $solutions.on 'click', () ->
        $(@).toggleClass('js-visible')
