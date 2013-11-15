define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  Backbone = require('backbone')
  settings = require('cs!settings')

  class Region
    constructor: (@el, @parent) ->

    show: (view) ->
      @empty()
      @append(view)

    append: (view) ->
      @appendAs('div', view)

    appendAs: (type, view) ->
      @$el = @parent.$el
      if @el then @$el = @parent.$el.find(@el)
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
      @empty()
      delete @[key] for key of @

  class Regions
    constructor: (regions = {}, $context) ->
      _.each _.keys(regions), (region) =>
        @[region] = new Region(regions[region], $context)

      # Add a self-referential region to attach views to
      @self = new Region(null, $context)

  return class BaseView extends Backbone.View
    initialize: () ->
      @regions = new Regions(@regions, @)

    _renderDom: (data) ->
      @$el?.html(@template?(data) or @template)

    # Update page title
    updateTitle: () ->
      document.title = settings.titlePrefix + @pageTitle if @pageTitle

    _render: () ->
      data = @model?.toJSON() or @collection?.toJSON() or {}

      if typeof @templateHelpers is 'function'
        _.extend(data, @templateHelpers())
      else
        # Add data from template helpers to the model's data
        _.each @templateHelpers, (value, key) =>
          if typeof value is 'function'
            data[key] = value.apply(@)
          else
            data[key] = value

      @updateTitle()
      @_renderDom(data)

    render: () ->
      @onBeforeRender?()
      @_render()
      @onRender?()
      if @_rendered then @onDomRefresh?() else @_rendered = true

      return @

    close: () ->
      @onBeforeClose?()

      _.each @regions, (region) ->
        region.close()

      @remove()
      @unbind()
      delete @[key] for key of @
      return @
