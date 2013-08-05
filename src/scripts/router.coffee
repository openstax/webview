define [
  'underscore'
  'backbone'
  'cs!pages/app/app'
], (_, Backbone, AppView) ->

  return new class Router extends Backbone.Router
    initialize: () ->
      @appView = new AppView()

      @route '', 'home', () ->
        @appView.render('home')

      @route 'content/:uuid', 'content', (uuid) ->
        @appView.render('content', {uuid: uuid})

      # Default Route
      @route '*actions', 'default', () ->
        @appView.render('home')
