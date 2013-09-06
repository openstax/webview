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
      @listenTo(@model, 'change', @render) if @model

    _renderDom: (data) ->
      @$el.html(@template?(data) or @template)

    _render: () ->
      data = @model?.toJSON() or {}

      if typeof @templateHelpers is 'function'
        _.extend(data, @templateHelpers(data))
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
      @stopListening()
      @remove()
      @unbind()
      delete @[key] for key of @
      return @

    detachPopovers: () ->
      @_popovers.pop().close() while @_popovers?.length

    attachPopover: (popover) ->
      @_popovers.push popover
