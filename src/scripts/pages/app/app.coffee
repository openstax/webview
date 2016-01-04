define (require) ->
  $ = require('jquery')
  linksHelper = require('cs!helpers/links')
  BaseView = require('cs!helpers/backbone/views/base')
  HeaderView = require('cs!modules/header/header')
  MinimalHeaderView = require('cs!modules/minimal/header/header')
  template = require('hbs!./app-template')
  require('less!./app')

  return class AppView extends BaseView
    el: 'body'
    template: template

    regions:
      header: '#header'
      main: '#scrollable-content'

    initialize: () ->
      super()
      @$el.html(@template)
      $window = $(window)
      throttleTime = 80

      $window.resize(_.throttle(->
        Backbone.trigger('window:optimizedResize')
      , throttleTime))

      $window.scroll(_.throttle(->
        Backbone.trigger('window:optimizedScroll')
      , throttleTime))

    render: (page, options) ->
      queryString = linksHelper.serializeQuery(location.search)
      @minimal = false
      if queryString.minimal
        @minimal = true
      headerView = if @minimal then new MinimalHeaderView() else new HeaderView()
      headerView.setLegacyLink('content')
      @regions.header.show(headerView)
      # Lazy-load the page
      require ["cs!pages/#{page}/#{page}"], (View) =>
        @regions.main.show(new View(options))
      return @
