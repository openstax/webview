define (require) ->
  Backbone = require('backbone')
  AppView = require('cs!pages/app/app')

  return new class Router extends Backbone.Router
    initialize: () ->
      @appView = new AppView()

      # Default Route
      @route '*actions', 'default', () ->
        @appView.render('home')

      @route 'content', 'content', () ->
        @appView.render('content')

      @route 'content/:uuid', 'media', (uuid) ->
        @appView.render('content', {uuid: uuid})
