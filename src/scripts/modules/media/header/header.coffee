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
      hasDownloads = _.isArray(@model.get 'downloads') or _.isArray(currentPage?.get('downloads'))

      if currentPage
        currentPage = currentPage.toJSON()
        currentPage.encodedTitle = encodeURI(currentPage.title)
      else
        currentPage = {
          title: 'Untitled'
          encodedTitle: 'Untitled'
          authors: []
        }

      return {currentPage: currentPage, hasDownloads: hasDownloads}

    regions:
      'button': '.info .btn'

    events:
      'click .summary h5': 'toggleSummary'

    initialize: () ->
      super()
      @listenTo(@model, 'change:downloads changePage', @render)

    onRender: () ->
      @regions.button.append new BookPopoverView
        model: @model
        owner: @$el.find('.info .btn')

    toggleSummary: (e) ->
      $summary = @$el.find('.summary')

      $summary.find('h5').toggleClass('active')
      @$el.find('.abstract').toggle()
