define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/base'
  'hbs!./info-block-template'
], ($, _, Backbone, BaseView, template) ->

  return class InfoBlockView extends BaseView
    title: 'Untitled'
    link: '#'
    linkTitle: 'More'

    initialize: () ->
      super()

      events =
        'click .more': 'more'

      # Re-delegate events with added 'more' event
      @events = @events or {}
      _.extend(events, @events)
      @delegateEvents(events)

    render: () ->
      @$el.html template
        title: @title
        link: @link
        linkTitle: @linkTitle
        content: @template

      return @

    more: () -> #noop
      console.log 'more'
