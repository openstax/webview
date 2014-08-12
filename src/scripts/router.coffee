define (require) ->
  Backbone = require('backbone')
  settings = require('settings')
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

      @route 'contents', 'contents', () ->
        @appView.render('contents')

      @route 'workspace', 'workspace', () ->
        @appView.render('workspace')

      # Match and extract uuid and page numbers separated by a colon
      @route /^contents\/([^:]+):?([0-9]*)/, 'media', (uuid, page) ->
        uuid = uuid.toLowerCase()
        uuid = settings.shortcodes[uuid] if settings.shortcodes[uuid]
        @appView.render('contents', {uuid: uuid, page: Number(page)})

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
