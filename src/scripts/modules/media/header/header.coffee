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
    media: 'page'

    template: template
    templateHelpers: () ->
      currentPage = @getModel()

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
        derivable: @isDerivable()
        authenticated: session.get('id')
        editable: @isEditable()
      }

    isEditable: () ->
      if @model.asPage()?.get('loaded') and @model.isDraft()
        edit = @model.asPage()?.get('canPublish')
        if edit isnt undefined and edit.toString().indexOf(session.get('id')) >= 0 and not @model.asPage()?.isDraft()
          return true

    isDerivable: () ->
      if @model.asPage()?.get('loaded') and @model.isDraft()
        canEdit = @model.asPage()?.get('canPublish')
        if canEdit isnt undefined and canEdit.toString().indexOf(session.get('id')) < 0
          return true


    editable:
      '.media-header > .title > h2':
        value: () -> 'title'
        type: 'textinput'

    regions:
      button: '.info .btn'

    events:
      'click .summary h5': 'toggleSummary'
      'click .derive .btn': 'derivePage'
      'click .edit .btn' : 'editPage'

    initialize: () ->
      super()

      @listenTo(@model, 'change:downloads change:buyLink change:title change:active', @render)
      @listenTo(@model, 'change:currentPage change:currentPage.active change:currentPage.loaded', @render)
      @listenTo(session, 'change', @render)
      @listenTo(@model, 'change:currentPage.editable change:currentPage.canPublish', @render)

    onRender: () ->
      if not @model.asPage()?.get('active') then return

      @regions.button.append new BookPopoverView
        model: @model
        owner: @$el.find('.info .btn')

    toggleSummary: (e) ->
      $summary = @$el.find('.summary')

      $summary.find('h5').toggleClass('active')
      @$el.find('.abstract').toggle()

    editPage: () ->
      data = JSON.stringify({id: @model.asPage().get('id')})
      options =
        success: (model) =>
          pageNumber = @model.getPageNumber()
          options =
            success: (model) ->
              router.navigate("/contents/#{model.id}@draft:#{pageNumber}", {trigger: false})

      @model.editOrDeriveContent(options, data)
      @model.asPage()?.set('version', 'draft')
      @model.asPage()?.set('editable',true)


    derivePage: () ->
      options =
        success: (model) =>
          @model.setPage(@model.getPageNumber(model))
          # Update the url bar path
          href = linksHelper.getPath 'contents',
            model: @model
            page: @model.getPageNumber()
          router.navigate(href, {trigger: false, analytics: true})

      @model.deriveCurrentPage(options)
