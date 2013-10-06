# Representation of individual nodes in a book's tree (table of contents).
# A Node can represent both a tree (subcollection), or leaf (page).
# Page Nodes also are used to cache a page's content once loaded.

define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  Backbone = require('backbone')
  settings = require('cs!settings')
  Page = require('cs!models/content/page')
  require('backbone-associations')

  CONTENT_URI = "#{location.protocol}//#{settings.cnxarchive.host}:#{settings.cnxarchive.port}/contents"

  return class Collection extends Backbone.AssociatedModel
    url: () -> "#{CONTENT_URI}/#{@id}"
    defaults:
      authors: []

    parse: (response, options) ->
      # Don't overwrite the title from the book's table of contents
      if @get('title')
        delete response.title

      return response

    relations: [{
      type: Backbone.Many
      key: 'contents'
      relatedModel: (relation, attributes) ->
        return (attrs, options) ->
          if _.isArray(attrs.contents)
            return new Collection(attrs)

          return new Page(attrs)
    }]
