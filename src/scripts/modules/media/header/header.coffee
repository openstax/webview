define [
  'jquery'
  'cs!helpers/backbone/views/base'
  'cs!./popovers/book/book'
  'hbs!./header-template'
  'less!./header'
], ($, BaseView, BookPopoverView, template) ->

  return class MediaHeaderView extends BaseView
    template: () -> template @content.toJSON()

    initialize: (options) ->
      super()
      @content = options.content
      
      @listenTo(@content.get('currentPage'), 'all', @render)

    render: () ->
      super()
      @attachPopover new BookPopoverView
        owner: @$el.find('.info .btn')
        content: @content.toJSON()
