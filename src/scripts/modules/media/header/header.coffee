define (require) ->
  _ = require('underscore')
  session = require('cs!session')
  EditableView = require('cs!helpers/backbone/views/editable')
  BookPopoverView = require('cs!./popovers/book/book')
  template = require('hbs!./header-template')
  require('less!./header')

  return class MediaHeaderView extends EditableView
    template: template
    templateHelpers: () ->
      if @model.isBook()
        currentPage = @model.get('currentPage')
      else
        currentPage = @model

      if currentPage
        currentPageData = currentPage.toJSON()
        currentPageData.encodedTitle = encodeURI(currentPage.title)
      else
        currentPageData = {
          title: 'Untitled'
          encodedTitle: 'Untitled'
          authors: []
        }

      downloads = @model.get('downloads')
      pageDownloads = currentPage?.get?('downloads')

      return {
        currentPage: currentPageData
        hasDownloads: (_.isArray(downloads) and downloads?.length) or
          (_.isArray(pageDownloads) and pageDownloads?.length)
        underivable: not currentPage?.isDraft()
        authenticated: session.get('username')
      }

    editable:
      '.media-header > .title > h2':
        value: () -> @getModel('title')
        type: 'textinput'

    regions:
      button: '.info .btn'

    events:
      'click .summary h5': 'toggleSummary'
      'click .derive .btn': 'derivePage'

    initialize: () ->
      super()
      @listenTo(@model, 'change:downloads change:buyLink change:loaded change:currentPage change:title', @render)
      @listenTo(session, 'change', @render)

    onRender: () ->
      @regions.button.append new BookPopoverView
        model: @model
        owner: @$el.find('.info .btn')

    toggleSummary: (e) ->
      $summary = @$el.find('.summary')

      $summary.find('h5').toggleClass('active')
      @$el.find('.abstract').toggle()

    derivePage: () -> @model.deriveCurrentPage()
