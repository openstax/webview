define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')
  BookPopoverView = require('cs!./popovers/book/book')
  template = require('hbs!./header-template')
  require('less!./header')

  return class MediaHeaderView extends BaseView
    template: template

    initialize: () ->
      super()
      @listenTo(@model.get('currentPage'), 'change', @render)

    onRender: () ->
      @attachPopover new BookPopoverView
        owner: @$el.find('.info .btn')
        content: @model.toJSON()
