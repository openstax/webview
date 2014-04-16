define (require) ->
  _ = require('underscore')
  EditableView = require('cs!helpers/backbone/views/editable')
  BookPopoverView = require('cs!./popovers/book/book')
  template = require('hbs!./header-template')
  require('less!./header')

  return class MediaHeaderView extends EditableView
    template: template
    templateHelpers: () ->
      currentPage = @model.asPage()

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

    editable:
      '.media-header > .title > h2':
        value: () -> @getModel('title')
        type: 'textinput'

    regions:
      button: '.info .btn'

    events:
      'click .summary h5': 'toggleSummary'

    initialize: () ->
      super()
      @listenTo(@model, 'change:downloads change:buyLink change:loaded change:currentPage change:title', @render)

    onRender: () ->
      @regions.button.append new BookPopoverView
        model: @model
        owner: @$el.find('.info .btn')

    toggleSummary: (e) ->
      $summary = @$el.find('.summary')

      $summary.find('h5').toggleClass('active')
      @$el.find('.abstract').toggle()
