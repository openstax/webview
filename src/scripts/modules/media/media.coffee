define (require) ->
  $ = require('jquery')
  linksHelper = require('cs!helpers/links')
  router = require('cs!router')
  analytics = require('cs!helpers/handlers/analytics')
  Content = require('cs!models/content')
  BaseView = require('cs!helpers/backbone/views/base')
  MainPageView = require('cs!modules/main-page/main-page')

  ContentsView = require('cs!modules/media/tabs/contents/contents')

  MediaEndorsedView = require('cs!./endorsed/endorsed')
  LatestView = require('cs!./latest/latest')
  MediaTitleView = require('cs!./title/title')
  MediaNavView = require('cs!./nav/nav')
  MediaHeaderView = require('cs!./header/header')
  WindowWithSidebarView = require('cs!modules/window-with-sidebar/window-with-sidebar')
  MediaBodyView = require('cs!./body/body')
  MediaFooterView = require('cs!./footer/footer')

  template = require('hbs!./media-template')
  require('less!./media')

  ###
  Returns an event handler that will handle hiding and showing
  items based on the scroll position. Attach the handler to
  a scroll event to hook it up.
  ###
  headerController = ($el, selector) ->
    threshold = window.innerHeight / 5
    fudge = 8
    hideAbove = threshold
    showBelow = fudge
    update = (event) ->
      return () ->
        Backbone.trigger 'window:resize'
    return (event) ->
      $hideables = $el.find(selector)
      top = $(event.target).scrollTop()
      if (top < showBelow and not $hideables.is(":visible"))
        $hideables.show(300, update(event))
      else if (top > hideAbove and $hideables.is(":visible"))
        $hideables.hide(300, update(event))

  return class MediaView extends BaseView
    key = []
    canonical: () ->
      uuid = @model.getUuid()
      if uuid
        return "//#{location.host}/contents/#{uuid}/"
      else
        return null

    template: template
    regions:
      media: '.media'
      editbar: '.editbar'

    summary:() -> @updateSummary()
    description: () -> @updateDescription()

    events:
      'keydown .media-title > .title input': 'checkKeySequence'
      'keyup .media-title > .title input': 'resetKeySequence'

    initialize: (options) ->
      super()

      if not options or not options.uuid
        throw new Error('A media view must be instantiated with the uuid of the media to display')

      @uuid = options.uuid
      @model = new Content({id: @uuid, version: options.version, page: options.page})
      @minimal = options.minimal

      @listenTo(@model, 'change:googleAnalytics', @trackAnalytics)
      @listenTo(@model, 'change:title change:parent.id', @updatePageInfo)
      if not @minimal
        @listenTo(@model, 'change:legacy_id change:legacy_version change:currentPage
          change:currentPage.loaded', @updateLegacyLink)
      @listenTo(@model, 'change:error', @displayError)
      @listenTo(@model, 'change:editable', @toggleEditor)
      @listenTo(@model, 'change:title change:currentPage change:currentPage.loaded', @updateUrl)
      @listenTo(@model, 'change:title change:currentPage change:currentPage.loaded', @updatePageInfo)
      @listenTo(@model, 'change:abstract', @updateSummary)

    onRender: () =>
      @regions.media.append(new MediaEndorsedView({model: @model}))
      @regions.media.append(new LatestView({model: @model}))
      mediaTitleView = new MediaTitleView({model: @model})
      @regions.media.append(mediaTitleView)
      navView = new MediaNavView({model: @model})
      @regions.media.append(navView)
      windowWithSidebar = new WindowWithSidebarView()
      @regions.media.append(windowWithSidebar)
      mainPage = new MainPageView()
      windowWithSidebar.regions.main.append(mainPage)
      mainPage.regions.main.append(new MediaHeaderView({model: @model}))
      navView.on('tocIsOpen', windowWithSidebar.open)
      tocView = new ContentsView({model: @model})
      windowWithSidebar.regions.sidebar.append(tocView)
      mainPage.regions.main.append(new MediaBodyView({model: @model}))
      mainPage.regions.main.append(new MediaFooterView({model: @model}))
      footerNav = new MediaNavView({model: @model, hideProgress: true, mediaParent: @})
      mainPage.regions.main.append(footerNav)
      footerNav.$el.addClass('footer-nav')
      @mainContent = windowWithSidebar.regions.main

      hideThese = mediaTitleView.$el
      headerHandler = headerController(hideThese, '.share')
      $('.fullsize-container .main').scroll(headerHandler)
      mainHeaderHandler = headerController($('#header'), '>div')
      $('.fullsize-container .main').scroll(mainHeaderHandler)

    updateSummary: () ->
      abstract = @model.get('abstract')
      if abstract
        return $("<div>#{abstract}</div>").text()
      else
        return 'An OpenStax CNX book'

    updateDescription: () ->
      if @model.get('currentPage')?.get('abstract')? and
      @model.get('currentPage').get('abstract').replace(/(<([^>]+)>)/ig, "") isnt ''
        # regular expression to strip tags
        return @model.get('currentPage').get('abstract').replace(/(<([^>]+)>)/ig, "")
      else
        return @updateSummary()

    updateUrl: () ->
      components = linksHelper.getCurrentPathComponents()
      components.version = "@#{components.version}" if components.version
      title = linksHelper.cleanUrl(@model.get('title'))
      qs = components.rawquery

      if title isnt components.title and not @model.isBook()
        router.navigate("contents/#{components.uuid}#{components.version}/#{title}#{qs}", {replace: true})

    trackAnalytics: () ->
      # Track loading using the media's own analytics ID, if specified
      analyticsID = @model.get('googleAnalytics')
      analytics.send(analyticsID) if analyticsID

    scrollToTop: () ->
      @mainContent.$el.scrollTop(0)

    updatePageInfo: () ->
      @pageTitle = @model.get('title')
      super()

    updateLegacyLink: () ->
      headerView = @parent.parent.regions.header.views[0]
      id = @model.get('legacy_id')
      version = @model.get('legacy_version')

      if @model.isBook()
        currentPage = @model.asPage()
        if currentPage
          pageId = currentPage.get('legacy_id')
          pageVersion = currentPage.get('legacy_version')
          if pageId and pageVersion
            headerView.setLegacyLink("content/#{pageId}/#{pageVersion}/?collection=#{id}/#{version}")
        return

      headerView.setLegacyLink("content/#{id}/#{version}") if id and version

    displayError: () ->
      error = arguments[1] # @model.get('error')
      router.appView.render('error', {code: error}) if error

    toggleEditor: () -> if @editing then @closeEditor() else @loadEditor()

    # FIX: How much of loadEditor and closeEditor can be merged into the editbar?
    loadEditor: () ->
      @editing = true

      require ['cs!./editbar/editbar'], (EditbarView) =>
        @regions.editbar.show(new EditbarView({model: @model}))
        height = @regions.editbar.$el.find('.navbar').outerHeight()
        $('body').css('padding-top', height) # Don't cover the page header
        window.scrollBy(0, height) # Prevent viewport from jumping

    closeEditor: () ->
      @editing = false
      height = @regions.editbar.$el.find('.navbar').outerHeight()
      @regions.editbar.empty()
      $('body').css('padding-top', '0') # Remove added padding
      window.scrollBy(0, -height) # Prevent viewport from jumping

    onBeforeClose: () ->
      if @model.get('editable')
        @model.set('editable', false, {silent: true})
        @closeEditor()

    checkKeySequence: (e) ->
      key[e.keyCode] = true
      #ctrl+alt+shift+l+i
      if key[16] and key[17] and key[18] and key[73] and key[76]
        if @model.get('canChangeLicense') or @model.get('derivedFrom') is null
          $('#license-modal').modal('show')

    resetKeySequence: (e) ->
      key[e.keyCode] = false
