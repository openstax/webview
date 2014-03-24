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

    add: () ->
      @get('contents').add(arguments...)

    create: (models, options) ->
      options.xhrFields =
        withCredentials: true
      options.wait = true # Always wait for a server response before adding the model to the collection
      options.withoutTransient = true # Remove transient properties before saving to the server

      if not _.isArray(models) then models = [models]

      _.each models, (model) =>
        @get('contents').create(model, options)
