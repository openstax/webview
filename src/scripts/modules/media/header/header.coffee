define (require) ->
  _ = require('underscore')
  session = require('cs!session')
  settings = require('settings')
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
        derivable: @isDerivable()
        authenticated: session.get('id')
        editable: @isEditable()
      }

    isEditable: () ->
      if @model.asPage()?.get('loaded') and @model.isDraft()
        edit = @model.asPage()?.get('canPublish')
        if edit isnt undefined and edit.toString().indexOf(session.get('id')) >= 0 and not @model.asPage()?.isDraft()
          @model.set('canChangeLicense', true)
          return true

    isDerivable: () ->
      if @model.asPage()?.get('loaded') and @model.isDraft()
        canEdit = @model.asPage()?.get('canPublish')
        if canEdit isnt undefined and canEdit.toString().indexOf(session.get('id')) < 0
          if @model.get('license')?.code isnt settings.defaultLicense.code
            @model.set('canChangeLicense', false)
          else
            @model.set('canChangeLicense', true)
          return true

    editable:
      '.media-header > .title > h2':
        value: () -> 'title'
        type: 'textinput'

    regions:
      button: '.info .btn'

    events:
      'click .summary': 'toggleSummary'
      'click .derive .btn': 'derivePage'
      'click .edit .btn' : 'editPage'
      'submit .info .btn': 'getBook'

    initialize: () ->
      super()

      @listenTo(@model, 'change:downloads change:buyLink change:title change:active', @render)
      @listenTo(@model, 'change:currentPage change:currentPage.active change:currentPage.loaded', @render)
      @listenTo(@model, 'change:abstract change:currentPage.abstract', @render)
      @listenTo(session, 'change', @render)
      @listenTo(@model, 'change:currentPage.editable change:currentPage.canPublish', @render)
      @listenTo(@model, 'change:currentPage', @updateTitle)
      @listenTo(router, 'navigate', @updatePageInfo)
      # make Ask Us tab-accessible by wrapping it in an anchor with the same location and size
      $askUs = $('#zenbox_tab')
      $askUsLink = $('<a id="zenbox_tab-wrap" href="#" tabIndex="5">').appendTo($('body'))
      $askUsLink.css($askUs.position())
      $askUsLink.width($askUs.width())
      $askUsLink.height($askUs.height())
      $askUs.appendTo($askUsLink)
      console.debug("Ask Us link:", $askUsLink)
      $askUsLink.click($askUs.click.bind($askUs))

    onRender: () ->
      if not @model.asPage()?.get('active') then return

      @regions.button.append new BookPopoverView
        model: @model
        owner: @$el.find('.info .btn')

    toggleSummary: (e) ->
      console.debug("Toggling!", e)
      e.preventDefault()
      $summary = @$el.find('.summary')
      $summary.find('h5').toggleClass('active')
      @$el.find('.abstract').toggle()

    editPage: () ->
      data = JSON.stringify({id: @model.asPage().get('id')})
      options =
        success: (model) =>
          @model.asPage()?.set('version', 'draft')
          @model.asPage()?.set('editable', true)
          href = linksHelper.getPath 'contents',
            model: @model
            page: @model.getPageNumber()
          router.navigate(href, {trigger: false, analytics: true})
      @model.editOrDeriveContent(options, data)

    getBook: (event) ->
      console.debug("Getting book", event)


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

    updateTitle: () ->
      @pageTitle = @model.get('title')
      if @model.asPage()?
        @pageTitle = "#{@model.get('currentPage').get('title')} - #{@model.get('title')}"
