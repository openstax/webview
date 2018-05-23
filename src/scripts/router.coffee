define (require) ->
  Backbone = require('backbone')
  settings = require('settings')
  linksHelper = require('cs!helpers/links')
  session = require('cs!session')
  analytics = require('cs!helpers/handlers/analytics')
  AppView = require('cs!pages/app/app')

  return new class Router extends Backbone.Router
    initialize: (args...) ->
      @appView = new AppView()

      # Default Route
      @route '*actions', 'default', () ->
        @appView.render('error', {code: 404})
        # Explicitly send analytics for each page so we can delay sending it for
        # content until the canonical URL is in the browser URL
        analytics.sendAnalytics()

      @route '', 'index', () ->
        @appView.render('home')
        # Explicitly send analytics for each page so we can delay sending it for
        # content until the canonical URL is in the browser URL
        analytics.sendAnalytics()


      @route 'contents', 'contents', () ->
        @appView.render('contents')
        analytics.sendAnalytics()

      @route 'browse', 'browse', ->
        @appView.render('browse-content')
        analytics.sendAnalytics()

      @route 'tos', 'tos', () ->
        @appView.render('tos')
        analytics.sendAnalytics()

      @route 'license', 'license', () ->
        @appView.render('license')
        analytics.sendAnalytics()


      # Match and extract uuid and page numbers separated by a colon
      @route linksHelper.contentsLinkRegEx, 'media', (uuid, version, page, title, qs) ->
        # Downcase uuids, not short ids
        if uuid.length > 10
          uuid = uuid.toLowerCase()
        uuid = settings.shortcodes[uuid] if settings.shortcodes[uuid]
        pageId = if isNaN(page) then page else Number(page)
        @appView.render('contents', {uuid: uuid, version: version, page: pageId, qs: qs})
        # Trust that canonicalizePath is called later
        # analytics.sendAnalytics()

      @route /^donate\/?([^/\?;]*)?\/?([^/\?;]*)?\/?([^/\?;]*)?(?:\?)?.*/, 'donate', (page, uuid, type) ->
        @appView.render('donate', {page: page, uuid: uuid, type: type})
        analytics.sendAnalytics()

      @route /^(search)(?:\?q=)?(.*)/, 'search', () ->
        @appView.render('search')
        analytics.sendAnalytics()

      @route /^about\/?(.*)/, 'about', (page) ->
        @appView.render('about', {page: page})
        analytics.sendAnalytics()

    navigate: (fragment, options = {}, cb) ->
      super(arguments...)
      cb?()
      @trigger('navigate')
