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

    initialize: () ->
      super()

      @_events =
        'click .more': 'more'

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

    more: (e) -> #noop
