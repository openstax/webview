define [
  'underscore'
  'backbone'
  'cs!pages/app/app'
], (_, Backbone, AppView) ->

  return new class Router extends Backbone.Router
    initialize: () ->
      @appView = new AppView()
      
      # Default Route
      @route '*actions', 'default', () ->
        console.log 'default'
        @appView.render('home')

      @route 'content', 'content', () ->
        console.log 'content'
        @appView.render('content')

      @route 'content/:uuid', 'content', (uuid) ->
        console.log 'content uuid'
        @appView.render('content', {uuid: uuid})
