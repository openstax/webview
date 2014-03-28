# Representation of individual nodes in a book's tree (table of contents).
# A Node can represent both a tree (section), or leaf (page).
# Page Nodes also are used to cache a page's content once loaded.

define (require) ->
  $ = require('jquery')
  Backbone = require('backbone')
  settings = require('settings')
  require('backbone-associations')

  ARCHIVE = "#{location.protocol}//#{settings.cnxarchive.host}:#{settings.cnxarchive.port}"
  AUTHORING = "#{location.protocol}//#{settings.cnxauthoring.host}:#{settings.cnxauthoring.port}"

  return class Node extends Backbone.AssociatedModel
    # url: () -> "#{SERVER}/contents/#{@id}"
    url: () ->
      id = @getVersionedId()

      if @isNew()
        url = "#{AUTHORING}/users/contents"
      else if @isDraft()
        url = "#{AUTHORING}/contents/#{id}.json" # FIX: Remove .json from URL
      else
        url = "#{ARCHIVE}/contents/#{id}.json"

      return url

    parse: (response, options) ->
      # Don't overwrite the title from the book's table of contents
      if @get('title') then delete response.title

      if response.mediaType is 'application/vnd.org.cnx.collection'
        response.contents = response.tree.contents or []

      else if response.mediaType is 'application/vnd.org.cnx.module'
        # FIX: cnx-authoring should not return a null value for content
        response.content = response.content or ''

        # jQuery can not build a jQuery object with <head> or <body> tags,
        # and will instead move all elements in them up one level.
        # Use a regex to extract everything in the body and put it into a div instead.
        $body = $('<div>' + response.content.replace(/^[\s\S]*<body.*?>|<\/body>[\s\S]*$/g, '') + '</div>')
        $body.children('.title').eq(0).remove()
        $body.children('.abstract').eq(0).remove()

        response.content = $body.html()

      return response

    fetch: (options = {}) ->
      if @isDraft()
        options.xhrFields = _.extend({withCredentials: true}, options.xhrFields)

      results = super(options)

      if @id
        @set('downloads', 'loading')

        if @isDraft() or not @get('version') # HACK for Untitled module
          @set('downloads', [])
          @set('isLatest', true)
        else
          $.ajax
            url: "#{ARCHIVE}/extras/#{@id}"
            dataType: 'json'
          .done (response) =>
            @set('downloads', response.downloads)
            @set('isLatest', response.isLatest)
          .fail () =>
            @set('downloads', [])

      return results

    save: () ->
      options = _.extend(
        xhrFields:
          withCredentials: true
        wait: true # Wait for a server response before adding the model to the collection
        excludeTransient: true # Remove transient properties before saving to the server
        includeTree: true
      , options)

      _.each @get('contents')?.models, (model) -> model.save()

      if @isNew()
        method = 'create'
      else
        method = 'update'

      if @isSaveable() and (@get('changed') or @isNew())
        xhr = @sync(method, @, options)
      else
        xhr = $.Deferred().resolve().promise()

      xhr.done () => @set('changed', false)

      return xhr

    get: (attr) ->
      response = super(arguments...)

      if response is undefined
        switch attr
          when 'depth'
            response = @attributes['parent']?.get('depth')
            if response isnt undefined then response++
            @set('depth', response)
          when 'book'
            response = @attributes['parent']?.get('book')
            @set('book', response)

      return response

    toJSON: (options = {}) ->
      results = super(arguments...)

      results.id = @getVersionedId()

      # FIX: Move all transient properties under 'meta'
      if options.excludeTransient
        delete results.loaded
        delete results.currentPage
        delete results.parent
        delete results.book
        delete results.type
        delete results.depth
        delete results.page
        delete results.changed
        delete results.active

      return results

    #
    # Utility Methods
    #

    getVersionedId: () ->
      components = @id?.match(/([^:@]+)@?([^:]*):?([0-9]*)/) or []
      id = components[1] or ''
      version = @get('version') or components[2]
      if version then version = "@#{version}" else version = ''

      return "#{id}#{version}"

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

    isSection: () -> @get('contents') instanceof Backbone.Collection

    isBook: () -> @get('mediaType') is 'application/vnd.org.cnx.collection'

    isDraft: () -> @get('version') is 'draft' or /@draft$/.test(@id)

    isSaveable: () -> !!@get('mediaType')
