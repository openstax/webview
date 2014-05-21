define (require) ->
  _ = require('underscore')
  $ = require('jquery')
  Backbone = require('backbone')
  Node = require('cs!./node')
  Page = require('cs!./page')
  require('backbone-associations')

  return class Collection extends Node
    relations: [{
      type: Backbone.Many
      key: 'contents'
      relatedModel: (relation, attributes) ->
        return (attrs, options) =>
          attrs.parent = @
          if _.isArray(attrs.contents)
            delete attrs.id # Get rid of the 'subcol' id so the section is unique
            return new Collection(attrs)

          return new Page(attrs)
    }]

    getTotalLength: () ->
      contents = @get('contents')
      length = 0

      if contents
        length = contents.reduce ((memo, node) -> memo + node.getTotalLength()), 0

      return length

    getPage: (num) ->
      page = 0

      for node in @get('contents').models
        position = node.getTotalLength() + page

        if position < num
          page = position
        else if num is position and not node.isSection() # Sections don't have page numbers
          return node
        else
          return node.getPage(num-page)

    toJSON: (options = {}) ->
      results = super(arguments...)

      # FIX: Subcollections having the id 'subcol' is kind of awkward, can this be removed from the db?
      results.id = @getVersionedId() or 'subcol'

      return results


    #
    # Proxy Backbone.Collection methods to make this model also work like a Collection
    #

    add: () ->
      results = @get('contents').add(arguments...)
      @set('changed', true)

      return results


    create: (models, options = {}) ->
      options = _.extend({
        xhrFields:
          withCredentials: true
        wait: true # Wait for a server response before adding the model to the collection
        excludeTransient: true # Remove transient properties before saving to the server
      }, options)

      if not _.isArray(models) then models = [models]

      contents = @get('contents')
      _.each models, (model) ->
        if model.derivedFrom
          opts = _.extend({derivedOnly: true}, options)

        contents.create(model, opts or options)

      @set('changed', true)

      return @

    save: () ->
      # save args for call to `super()`
      args = arguments
      # First, save all the models in the collection
      promises = _.map @get('contents')?.models, (model) -> model.save()

      # Save the collection once all the models have completed saving
      return $.when(promises...).then () =>
        # Don't save subcollections
        if @isSaveable()
          xhr = super(args...).then () =>
            @set('changed', false)
            @set('childChanged', false)
        else
          xhr = $.Deferred().resolve().promise()

        return xhr
