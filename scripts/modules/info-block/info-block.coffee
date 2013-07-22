define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/base'
  'hbs!./info-block-template'
  'less!./info-block'
], ($, _, Backbone, BaseView, template) ->

  return class InfoBlockView extends BaseView
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

    render: () ->
      @beforeRender?()

      @$el.html template
        title: @title
        link: @link
        linkTitle: @linkTitle
        content: @template?() or @template
      @delegateEvents(@_events)

      @afterRender?()

      return @

    clickMore: (e) ->
      e.preventDefault()

      if @_expanded
        @_expanded = false
        @$el.find('.link-title').text(@linkTitle)
        @less?()
      else
        @_expanded = true
        @$el.find('.link-title').text(@linkExpandedTitle)
        @more?()
