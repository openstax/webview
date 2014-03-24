define (require) ->
  _ = require('underscore')
  Backbone = require('backbone')
  Node = require('cs!./node')
  Page = require('cs!./page')
  require('backbone-associations')

  return class Collection extends Node
    defaults:
      title: 'Untitled'
      authors: []

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

      if contents
        return contents.reduce ((memo, node) -> memo + node.getTotalLength()), 0

      return 0

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


    #
    # Proxy Backbone.Collection methods to make this model also work like a Collection
    #

    add: () -> @get('contents').add(arguments...)

    create: (models, options = {}) ->
      options = _.extend({
        xhrFields:
          withCredentials: true
        wait: true # Wait for a server response before adding the model to the collection
        withoutTransient: true # Remove transient properties before saving to the server
      }, options)

      if not _.isArray(models) then models = [models]

      contents = @get('contents')
      _.each models, (model) ->
        contents.create(model, options)

    save: () ->
      # FIX: Pass the proper arguments to super

      options =
        xhrFields:
          withCredentials: true
        wait: true # Wait for a server response before adding the model to the collection
        withoutTransient: true # Remove transient properties before saving to the server

      if arguments[0]? or not _.isObject(arguments[0])
        arguments[1] = _.extend(options, arguments[1])
      else
        arguments[2] = _.extend(options, arguments[2])

      xhr = super(null, options)

      _.each @get('contents')?.models, (model) ->
        if model.get('changed') or model.isNew()
          model.save(null, options)

      return xhr
