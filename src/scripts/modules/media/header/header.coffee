define (require) ->
  _ = require('underscore')
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

      downloads = @model.get('downloads')
      pageDownloads = currentPage?.get?('downloads')

      return {
        currentPage: currentPage
        hasDownloads: (_.isArray(downloads) and downloads?.length) or
          (_.isArray(pageDownloads) and pageDownloads?.length)
      }

    regions:
      'button': '.info .btn'

    events:
      'click .summary h5': 'toggleSummary'

    initialize: () ->
      super()
      @listenTo(@model, 'change:downloads change:buyLink changePage', @render)
      @listenTo(@model, 'change:edit', @toggleEdit)

    onRender: () ->
      @regions.button.append new BookPopoverView
        model: @model
        owner: @$el.find('.info .btn')

    toggleSummary: (e) ->
      $summary = @$el.find('.summary')

      $summary.find('h5').toggleClass('active')
      @$el.find('.abstract').toggle()

    toggleEdit: () ->
      @$el.children('.media-header').children('h2').attr('contenteditable', @model.get('edit'))
