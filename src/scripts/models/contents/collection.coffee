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
        return (attrs, options) ->
          if _.isArray(attrs.contents)
            return new Collection(attrs)

          return new Page(attrs)
    }]
