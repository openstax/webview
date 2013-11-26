define (require) ->
  Backbone = require('backbone')
  AppView = require('cs!pages/app/app')

  return new class Router extends Backbone.Router
    initialize: () ->
      @appView = new AppView()

      # Default Route
      @route '*actions', 'default', () ->
        @appView.render('404')

      @route '', 'index', () ->
        @appView.render('home')

      @route 'content', 'content', () ->
        @appView.render('content')

      # Match and extract uuid and page numbers separated by a colon
      @route /^content\/([^:]+):?(.*)/, 'media', (uuid, page) ->
        @appView.render('content', {uuid: uuid, page: page})

      @route /^search/, 'search', () ->
        @appView.render('search')

    navigate: () ->
      super(arguments...)
      @trigger('navigate')

    # Helper function to determine the current route's parameters
    current: () ->
      routes = []
      params = null

      # Find the route matching the current URL
      _.each Backbone.history.handlers, (handler) -> routes.push(handler.route)
      matched = _.find routes, (route) -> route.test(Backbone.history.fragment)

      # Determine the matching route parameters
      if matched then params = @_extractParameters(matched, Backbone.history.fragment)

      return {
        regex: matched
        fragment: Backbone.history.fragment
        params: params
      }
