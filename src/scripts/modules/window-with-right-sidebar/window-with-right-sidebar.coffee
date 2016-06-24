define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./window-with-right-sidebar-template')
  require('less!./window-with-right-sidebar')

  return class WindowWithRightSidebarView extends BaseView
    template: template
    regions:
      container: '.fullsize-right-container'
      sidebar: '.sidebar'
      main: '.main'

    initialize: ->
      super()

    open: (whether) =>
      $el = $(@regions.container.el)
      if whether
        $el.addClass('sidebar-open')
      else
        $el.removeClass('sidebar-open')

    onRender: ->
      super()
      @$el.addClass('fullsize-right-container')
