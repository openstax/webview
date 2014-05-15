define (require) ->
  _ = require('underscore')
  session = require('cs!session')
  linksHelper = require('cs!helpers/links')
  router = require('cs!router')
  EditableView = require('cs!helpers/backbone/views/editable')
  BookPopoverView = require('cs!./popovers/book/book')
  template = require('hbs!./header-template')
  require('less!./header')

  return class MediaHeaderView extends EditableView
    template: template
    templateHelpers: () ->
      currentPage = @model.asPage()

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
        derivable: not currentPage?.isDraft() and @model.isDraft()
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

    isEditable: () ->
      if @model.isBook()
        return @model.get('currentPage')?.isEditable()

      return @model.isEditable()

    toggleSummary: (e) ->
      $summary = @$el.find('.summary')

      $summary.find('h5').toggleClass('active')
      @$el.find('.abstract').toggle()

    derivePage: () ->
      options =
        success: (model) =>
          @model.setPageNumber(@model.get('contents').indexOf(model)+1)
          # Update the url bar path
          href = linksHelper.getPath 'contents',
            model: @model
            page: @model.getPageNumber()
          router.navigate(href, {trigger: false, analytics: true})

      @model.deriveCurrentPage(options)
