define [
  'jquery'
  'underscore'
  'backbone'
], ($, _, Backbone) ->

  class Region
    constructor: (el, parent) ->
      @parent = parent
      @el = el

    show: (view) ->
      @close()
      @views = null
      @append(view)

    append: (view) ->
      @$el = @$el or @parent.$el.find(@el).eq(0)
      view.parent = @parent
      @views ?= []
      @views.push(view)
      view.setElement($('<div>').appendTo(@$el)).render()

    close: () ->
      _.each @views, (view) ->
        view.close()

      @$el?.empty()

  class Regions
    constructor: (regions, $context) ->
      _.each _.keys(regions), (region) =>
        @[region] = new Region(regions[region], $context)

  return class BaseView extends Backbone.View
    initialize: () ->
      @regions = new Regions(@regions, @)

    render: () ->
      @$el.html(@template)

      return @

    close: () ->
      _.each @regions, (region) ->
        region.close()

      @parent = null
      @stopListening()
      @remove()
      @unbind()
