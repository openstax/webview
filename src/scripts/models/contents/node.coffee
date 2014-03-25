# Representation of individual nodes in a book's tree (table of contents).
# A Node can represent both a tree (section), or leaf (page).
# Page Nodes also are used to cache a page's content once loaded.

define (require) ->
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
        url = "#{AUTHORING}/contents"
      else if @isDraft()
        url = "#{AUTHORING}/contents/#{id}.json" # FIX: Remove .json from URL
      else
        url = "#{ARCHIVE}/contents/#{id}.json"

      return url

    parse: (response, options) ->
      # Don't overwrite the title from the book's table of contents
      if @get('title') then delete response.title

      return response

    fetch: (options) ->
      results = super(arguments...)

      if @id
        @set('downloads', 'loading')

        if @get('version') is 'draft' or not @get('version') # HACK for Untitled module
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
      # FIX: Pass the proper arguments to super

      options =
        xhrFields:
          withCredentials: true
        wait: true # Wait for a server response before adding the model to the collection
        excludeTransient: true # Remove transient properties before saving to the server

      if arguments[0]? or not _.isObject(arguments[0])
        arguments[1] = _.extend(options, arguments[1])
      else
        arguments[2] = _.extend(options, arguments[2])

      xhr = super(null, options)
      xhr.done () => @set('changed', false)

      return xhr

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

    toJSON: (options = {}) ->
      results = super(arguments...)

      results.id = @getVersionedId()

      # FIX: Move all transient properties under 'meta'
      if options.excludeTransient
        delete results.meta
        delete results.loaded
        delete results.currentPage
        delete results.parent
        delete results.book
        delete results.type
        delete results.parent
        delete results.depth
        delete results.page

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

    isBook: () -> @get('type') is 'book'

    isDraft: () -> @get('version') is 'draft' or /@draft$/.test(@id)
