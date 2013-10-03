define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  Backbone = require('backbone')

  class Region
    constructor: (el, parent) ->
      @parent = parent
      @el = el

    show: (view) ->
      @empty()
      @append(view)

    append: (view) ->
      @appendAs('div', view)

    appendAs: (type, view) ->
      @$el = @parent.$el.find(@el)
      view.parent = @parent
      @views ?= []
      @views.push(view)
      view.setElement($("<#{type}>").appendTo(@$el)).render()

    empty: () ->
      _.each @views, (view) ->
        view.close()

      @$el?.empty()
      @$el = null
      @views = null

    close: () ->
      empty()
      delete @[key] for key of @

  class Regions
    constructor: (regions = {}, $context) ->
      _.each _.keys(regions), (region) =>
        @[region] = new Region(regions[region], $context)

  return class BaseView extends Backbone.View
    initialize: () ->
      @_popovers = []
      @regions = new Regions(@regions, @)

    _renderDom: (data) ->
      @$el?.html(@template?(data) or @template)

    _render: () ->
      data = @model?.toJSON() or {}

      if typeof @templateHelpers is 'function'
        _.extend(data, @templateHelpers())
      else
        # Add data from template helpers to the model's data
        _.each @templateHelpers, (value, key) =>
          if typeof value is 'function'
            data[key] = value.apply(@)
          else
            data[key] = value

      @_renderDom(data)

    render: () ->
      @onBeforeRender?()
      @detachPopovers()
      @_render()
      @onRender?()
      if @_rendered then @onDomRefresh?() else @_rendered = true

      return @

    close: () ->
      @onBeforeClose?()

      _.each @regions, (region) ->
        region.close()

      @detachPopovers()
      @remove()
      @unbind()
      delete @[key] for key of @
      return @

    detachPopovers: () ->
      @_popovers.pop().close() while @_popovers?.length

    attachPopover: (popover) ->
      @_popovers.push popover
