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
      @$el = @$el or @parent.$el.find(@el)
      view.parent = @parent
      @view = view
      @view.setElement(@$el).render()

    close: () ->
      @view?.close()
      @$el.empty()

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
        region.view.close()

      @stopListening()
      @remove()
      @unbind()
