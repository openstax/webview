# Representation of individual nodes in a book's tree (table of contents).
# A Node can represent both a tree (subcollection), or leaf (page).
# Page Nodes also are used to cache a page's content once loaded.

define (require) ->
  Backbone = require('backbone')
  settings = require('settings')
  require('backbone-associations')

  SERVER = "#{location.protocol}//#{settings.cnxarchive.host}:#{settings.cnxarchive.port}"

  return class Node extends Backbone.AssociatedModel
    url: () -> "#{SERVER}/contents/#{@id}"

    parse: (response, options) ->
      # Don't overwrite the title from the book's table of contents
      if @get('title') then delete response.title

      return @parseInfo(response)

    parseInfo: (response) ->
      # Add languageName property to nodes for faster references in views
      response.languageName = settings.languages[response.language]

      return response

    fetch: (options) ->
      super(arguments...)

      if not @id then return

      @set('downloads', 'loading')

      $.ajax
        url: "#{SERVER}/extras/#{@id}"
        dataType: 'json'
      .done (response) =>
        @set('downloads', response.downloads)
        @set('isLatest', response.isLatest)
      .fail () =>
        @set('downloads', [])
