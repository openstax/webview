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
            attrs.subcollection = true
            delete attrs.id # Get rid of the 'subcol' id so the subcollection is unique
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
        else if num is position and not node.get('subcollection')
          return node
        else
          return node.getPage(num-page)
