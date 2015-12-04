define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./window-with-sidebar-template')
  require('less!./window-with-sidebar')

  return class WindowWithSidebarView extends BaseView
    template: template
    regions:
      container: '.fullsize-container'
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
      @$el.addClass('fullsize-container')
