define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./info-block-template')
  require('less!./info-block')

  return class InfoBlockView extends BaseView
    _infoTemplate: template

    title: 'Untitled'
    link: '#'
    linkTitle: 'More'
    linkExpandedTitle: 'Less'

    initialize: () ->
      super()

      @_events =
        'click .more': 'clickMore'

      # Re-delegate events with added 'more' event
      @events = @events or {}
      _.extend(@_events, @events)

    renderDom: () ->
      @$el.html @_infoTemplate
        title: @title
        link: @link
        linkTitle: @linkTitle
        content: @getTemplate()

      @delegateEvents(@_events)

    clickMore: (e) ->
      e.preventDefault()

      @toggleDivs()

      if @_expanded
        @_expanded = false
        @$el.find('.link-title').text(@linkTitle)
        @$el.find('.arrow').text('▸')
        @less?()
      else
        @_expanded = true
        @$el.find('.link-title').text(@linkExpandedTitle)
        @$el.find('.arrow').text('▾')
        @more?()

    toggleDivs: () ->
      $('#carousel').toggle()
      $('#openstax').toggle()
      $('#cnx').toggle()
