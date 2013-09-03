define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  Backbone = require('backbone')

  class Region
    constructor: (el, parent) ->
      @parent = parent
      @el = el

    show: (view) ->
      @close()
      @views = null
      @append(view)

    append: (view) ->
      @$el = @$el or @parent.$el.find(@el)
      view.parent = @parent
      @views ?= []
      @views.push(view)
      view.setElement($('<div>').appendTo(@$el)).render()

    close: () ->
      _.each @views, (view) ->
        view.close()

      @$el?.empty()

  class Regions
    constructor: (regions = {}, $context) ->
      _.each _.keys(regions), (region) =>
        @[region] = new Region(regions[region], $context)

  return class BaseView extends Backbone.View
    initialize: () ->
      @_popovers = []
      @regions = new Regions(@regions, @)

    render: () ->
      @detachPopovers()
      @$el.html(@template?() or @template)

      return @

    close: () ->
      _.each @regions, (region) ->
        region.close()

      @detachPopovers()
      @stopListening()
      @remove()
      @unbind()
      delete @[key] for key of @
      return @

    detachPopovers: () ->
      @_popovers.pop().close() while @_popovers?.length

    attachPopover: (popover) ->
      @_popovers.push popover
