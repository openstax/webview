define [
  'underscore'
  'backbone',
  'cs!views/app'
], (_, Backbone, appView) ->

  return new class Router extends Backbone.Router
    initialize: () ->
      @route '', 'home', () ->
        appView.render('home')

      # Default Route
      @route '*actions', 'default', () ->
        appView.render('home')
