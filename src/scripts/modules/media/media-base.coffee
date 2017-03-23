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
      pinnable: '.pinnable'

    summary:() -> @updateSummary()
    description: () -> @updateDescription()

    events:
      'click a[href*="#"]': 'triggerHashChange'

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
      @listenTo(@model, 'change:title change:currentPage change:currentPage.loaded', @updateUrl)
      @listenTo(@model, 'change:title change:currentPage change:currentPage.loaded', @updatePageInfo)
      @listenTo(@model, 'change:abstract', @updateSummary)

    triggerHashChange: (e) ->
      Backbone.trigger('window:hashChange')

    onRender: () =>
      @regions.media.append(new MediaEndorsedView({model: @model}))
      @regions.media.append(new LatestView({model: @model}))
      mediaTitleView = new MediaTitleView({model: @model})
      navView = new MediaNavView({model: @model})
      windowWithSidebar = new WindowWithSidebarView()
      tocView = new ContentsView({model: @model})
      footerNav = new MediaNavView({model: @model, hideProgress: true, mediaParent: @})
      @regions.pinnable.append(mediaTitleView)
      @regions.pinnable.append(navView)
      @regions.media.append(windowWithSidebar)
      mainPage = new MainPageView()
      windowWithSidebar.regions.main.append(mainPage)
      mediaBody = new MediaBodyView({model: @model})
      mainPage.regions.main.append(new MediaHeaderView({
        model: @model
        mediaParent: @
        mediaBody: mediaBody
      }))
      windowWithSidebar.regions.sidebar.append(tocView)
      mediaBodyView = mediaBody
      mainPage.regions.main.append(mediaBodyView)
      mainPage.regions.main.append(new MediaFooterView({model: @model}))
      mainPage.regions.main.append(footerNav)
      footerNav.$el.addClass('footer-nav')
      @mainContent = windowWithSidebar.regions.main

      $pinnable = @regions.pinnable.$el
      pinnableTop = $pinnable.offset().top
      $toc = tocView.$el
      isPinned = false
      setTocHeight = ->
        tocTop = $pinnable.height()
        if not isPinned
          tocTop += $pinnable.offset().top
        $toc.css('top', "#{tocTop}px")
        newHeight = window.innerHeight - tocTop
        $toc.height("#{newHeight}px")
      Backbone.on('window:optimizedResize', setTocHeight)

      adjustHashTop = ->
        handleHeaderViewPinning()
        if isPinned
          obscured = $pinnable.height()
          top = $(window.location.hash)?.position()?.top
          $(window).scrollTop(top - obscured) if top

      Backbone.on('window:hashChange', _.debounce(adjustHashTop, 150))

      # closing is triggered in 'onBeforeClose'
      @on('closing', ->
        Backbone.off('window:optimizedResize', setTocHeight)
        Backbone.off('window:hashChange', adjustHashTop)
      )

      adjustMainMargin = (height) ->
        mainPage.regions.main.$el.css('margin-top', "#{height}px")

      $titleArea = mediaTitleView.$el.find('.media-title')
      pinNavBar = ->
        $pinnable.addClass('pinned')
        $titleArea.addClass('compact')
        $toc.addClass('pinned')
        isPinned = true
        adjustMainMargin($pinnable.height())
      unpinNavBar = ->
        $pinnable.removeClass('pinned')
        $titleArea.removeClass('compact')
        $toc.removeClass('pinned')
        isPinned = false
        adjustMainMargin(0)
        pinnableTop = $pinnable.offset().top
      mediaTitleView.on('render', ->
        $titleArea = mediaTitleView.$el.find('.media-title')
        $titleArea.addClass('compact') if isPinned
      )

      handleHeaderViewPinning = ->
        top = $(window).scrollTop()
        if top > pinnableTop
          if not isPinned
            pinNavBar()
        else if isPinned
          unpinNavBar()
        setTocHeight()
      Backbone.on('window:optimizedScroll', handleHeaderViewPinning)
      # closing is triggered in 'onBeforeClose'
      @on('closing', ->
        Backbone.off('window:optimizedScroll', handleHeaderViewPinning)
      )

      navView.on('tocIsOpen', (whether) ->
        windowWithSidebar.open(whether)
        # On small screens, when the contents is opened,
        # auto-scroll to make header minimize
        if window.innerWidth < 640 and whether
          top = $(window).scrollTop()
          if top < pinnableTop
            $(window).scrollTop(pinnableTop + 10)
        setTocHeight()
        )
      wasPinnedAtChange = false
      @model.on('change:currentPage', ->
        wasPinnedAtChange = isPinned
      )
      mediaBodyView.on('render', ->
        scrollTo = if wasPinnedAtChange then pinnableTop + 1 else 0
        $(window).scrollTop(scrollTo)
      )

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
      title = linksHelper.cleanUrl(linksHelper.stripTags(@model.get('title')))
      qs = components.rawquery

      if title isnt components.title and not @model.isBook()
        router.navigate("contents/#{components.uuid}#{components.version}/#{title}#{qs}", {replace: true})

    trackAnalytics: () ->
      # Track loading using the media's own analytics ID, if specified
      analyticsID = @model.get('googleAnalytics')
      analytics.send(analyticsID) if analyticsID

    updatePageInfo: () ->
      @pageTitle = @model.get('title')
      super()

    updateLegacyLink: () ->
      headerView = @parent.parent.regions.header.views?[0]
      return unless headerView?
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

    onBeforeClose: () ->
      @trigger('closing')
