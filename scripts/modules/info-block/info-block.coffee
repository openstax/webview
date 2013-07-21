define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/base'
], ($, _, Backbone, BaseView) ->

  return class InfoBlockView extends BaseView
    initialize: () ->
      super()

      events =
        'click .more': 'more'

      @events = @events or {}
      _.extend(events, @events)

      @delegateEvents(events)

      # add a content region to add views to and automatically insert them

    more: () -> #noop