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

    get: (attr) ->
      if @attributes[attr] isnt undefined
        return @attributes[attr]

      switch attr
        when 'depth'
          response = @attributes['parent']?.get('depth')
          if response isnt undefined then response++
          @set('depth', response)
        when 'book'
          response = @attributes['parent']?.get('book')
          @set('book', response)

      return response

    index: () -> @get('parent').get('contents').indexOf(@)

    getTotalLength: () -> 1

    getPageNumber: (model = @) -> 1 + model?.previousPageCount()

    # Determine if a model is an ancestor of this node
    hasAncestor: (model) ->
      parent = @get('parent')

      if not parent
        return false
      else if parent is model
        return true
      else
        return parent.hasAncestor(model)

    previousPageCount: () ->
      parent = @get('parent')

      if not parent then return 0

      contents = parent.get('contents').slice(0, @index())

      pages = _.reduceRight contents, ((memo, node) -> memo + node.getTotalLength()), 0

      if parent isnt @get('book')
        pages += parent.previousPageCount()

      return pages
