define [
  'jquery'
  'cs!helpers/backbone/views/base'
  'cs!./popovers/book/book'
  'hbs!./header-template'
  'less!./header'
], ($, BaseView, BookPopoverView, template) ->

  return class MediaHeaderView extends BaseView
    initialize: (options) ->
      super()
      @content = options.content
      @template = template @content.toJSON()

    render: () ->
      super()
      @attachPopover new BookPopoverView
        owner: @$el.find('.info .btn')
        content: @content
