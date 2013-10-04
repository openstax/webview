define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')
  BookPopoverView = require('cs!./popovers/book/book')
  template = require('hbs!./header-template')
  require('less!./header')

  return class MediaHeaderView extends BaseView
    template: template
    templateHelpers: () ->
      currentPage = @model.get('currentPage')

      if currentPage
        currentPage = currentPage.toJSON()
        currentPage.encodedTitle = encodeURI(currentPage.title)
      else
        currentPage = {
          title: 'Untitled'
          encodedTitle: 'Untitled'
          authors: []
        }

      return {currentPage: currentPage}

    initialize: () ->
      super()
      @listenTo(@model, 'change:currentPage', @render)

    onRender: () ->
      @attachPopover new BookPopoverView
        owner: @$el.find('.info .btn')
        content: @model.toJSON()
