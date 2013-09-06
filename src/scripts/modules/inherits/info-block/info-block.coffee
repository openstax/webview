define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./info-block-template')
  require('less!./info-block')

  return class InfoBlockView extends BaseView
    title: 'Untitled'
    link: '#'
    linkTitle: 'More'
    linkExpandedTitle: 'Less'

    templateHelpers: () -> {
      title: @title
      link: @link
      linkTitle: @linkTitle
      content: @template?() or @template
    }

    initialize: () ->
      super()

      @_events =
        'click .more': 'clickMore'

      # Re-delegate events with added 'more' event
      @events = @events or {}
      _.extend(@_events, @events)

    _renderDom: (data) ->
      @$el.html(template(data))
      @delegateEvents(@_events)

    clickMore: (e) ->
      e.preventDefault()

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
