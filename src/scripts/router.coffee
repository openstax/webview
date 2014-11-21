define (require) ->
  Backbone = require('backbone')
  settings = require('settings')
  linksHelper = require('cs!helpers/links')
  session = require('cs!session')
  analytics = require('cs!helpers/handlers/analytics')
  AppView = require('cs!pages/app/app')

  return new class Router extends Backbone.Router
    initialize: () ->
      @appView = new AppView()

      # Default Route
      @route '*actions', 'default', () ->
        @appView.render('error', {code: 404})

      @route '', 'index', () ->
        @appView.render('home')

      @route 'workspace', 'workspace', () ->
        @appView.render('workspace')

      @route 'contents', 'contents', () ->
        @appView.render('contents')

      @route /^users\/role-acceptance\/(.+)/, 'role-acceptance', () ->
        @appView.render('role-acceptance')

      # Match and extract uuid and page numbers separated by a colon
      @route linksHelper.componentRegEx, 'media', (uuid, version, page) ->
        uuid = uuid.toLowerCase()
        uuid = settings.shortcodes[uuid] if settings.shortcodes[uuid]
        @appView.render('contents', {uuid: uuid, version: version, page: Number(page)})

      @route /^donate\/?([^/\?;]*)?\/?([^/\?;]*)?\/?([^/\?;]*)?(?:\?)?.*/, 'donate', (page, uuid, type) ->
        @appView.render('donate', {page: page, uuid: uuid, type: type})

      @route /^(search)(?:\?q=)?(.*)/, 'search', () ->
        @appView.render('search')

      @route /^about\/?(.*)/, 'about', (page) ->
        @appView.render('about', {page: page})

    navigate: (fragment, options = {}, cb) ->
      super(arguments...)
      session.update() # Check for changes to the session status
      analytics.send() if options.analytics isnt false
      cb?()
      @trigger('navigate')
