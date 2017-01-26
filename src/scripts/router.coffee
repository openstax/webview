define (require) ->
  Backbone = require('backbone')
  settings = require('settings')
  linksHelper = require('cs!helpers/links')
  session = require('cs!session')
  analytics = require('cs!helpers/handlers/analytics')
  AppView = require('cs!pages/app/app')
  setupRoutesForAuthoring = require('cs!routes-authoring')
  hasAuthoring = settings.hasFeature('authoring')

  return new class Router extends Backbone.Router
    initialize: (args...) ->
      decodedPathname = decodeURIComponent(window.location.pathname)
      if (decodedPathname != window.location.pathname)
        window.location.replace(decodeURIComponent(window.location))
      @appView = new AppView()

      # Default Route
      @route '*actions', 'default', () ->
        @appView.render('error', {code: 404})

      @route '', 'index', () ->
        @appView.render('home')

      @route 'contents', 'contents', () ->
        @appView.render('contents')

      @route 'browse', 'browse', ->
        @appView.render('browse-content')

      @route 'tos', 'tos', () ->
        @appView.render('tos')

      @route 'license', 'license', () ->
        @appView.render('license')

      setupRoutesForAuthoring(@) if hasAuthoring

      # Match and extract uuid and page numbers separated by a colon
      @route linksHelper.contentsLinkRegEx, 'media', (uuid, version, page, title, qs) ->
        # Downcase uuids, not short ids
        if uuid.length > 10
          uuid = uuid.toLowerCase()
        uuid = settings.shortcodes[uuid] if settings.shortcodes[uuid]
        pageId = if isNaN(page) then page else Number(page)
        @appView.render('contents', {uuid: uuid, version: version, page: pageId, qs: qs})

      @route /^donate\/?([^/\?;]*)?\/?([^/\?;]*)?\/?([^/\?;]*)?(?:\?)?.*/, 'donate', (page, uuid, type) ->
        @appView.render('donate', {page: page, uuid: uuid, type: type})

      @route /^(search)(?:\?q=)?(.*)/, 'search', () ->
        @appView.render('search')

      @route /^about\/?(.*)/, 'about', (page) ->
        @appView.render('about', {page: page})

    navigate: (fragment, options = {}, cb) ->
      super(arguments...)
      session.update() if hasAuthoring # Check for changes to the session status
      analytics.send() if options.analytics isnt false
      cb?()
      @trigger('navigate')
