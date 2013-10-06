# Representation of individual nodes in a book's tree (table of contents).
# A Node can represent both a tree (subcollection), or leaf (page).
# Page Nodes also are used to cache a page's content once loaded.

define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  Backbone = require('backbone')
  settings = require('cs!settings')
  toc = require('cs!collections/toc')
  require('backbone-associations')

  CONTENT_URI = "#{location.protocol}//#{settings.cnxarchive.host}:#{settings.cnxarchive.port}/contents"

  return class Page extends Backbone.AssociatedModel
    url: () -> "#{CONTENT_URI}/#{@id}"
    defaults:
      authors: []

    constructor: () ->
      super(arguments...)
      toc.add(@)

    parse: (response, options) ->
      # Don't overwrite the title from the book's table of contents
      if @get('title')
        delete response.title

      # jQuery can not build a jQuery object with <head> or <body> tags,
      # and will instead move all elements in them up one level.
      # Use a regex to extract everything in the body and put it into a div instead.
      $body = $('<div>' + response.content.replace(/^[\s\S]*<body.*?>|<\/body>[\s\S]*$/g, '') + '</div>')
      $body.children('.title').eq(0).remove()
      response.content = $body.html()

      return response
