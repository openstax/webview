# Representation of individual nodes in a book's tree (table of contents).
# A Node can represent both a tree (subcollection), or leaf (page).
# Page Nodes also are used to cache a page's content once loaded.

define (require) ->
  Backbone = require('backbone')
  settings = require('cs!settings')
  require('backbone-associations')

  CONTENT_URI = "#{location.protocol}//#{settings.cnxarchive.host}:#{settings.cnxarchive.port}/contents"

  return class Node extends Backbone.AssociatedModel
    url: () -> "#{CONTENT_URI}/#{@id}"

    parse: (response, options) ->
      # Don't overwrite the title from the book's table of contents
      if @get('title')
        delete response.title
