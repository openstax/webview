define [
  'jquery'
  'cs!helpers/backbone/views/base'
  'cs!./popovers/book/book'
  'hbs!./header-template'
  'less!./header'
], ($, BaseView, BookPopoverView, template) ->

  return class MediaHeaderView extends BaseView
    template: template()

    render: () ->
      super()

      @attachPopover new BookPopoverView({owner: @$el.find('.info .btn')})
