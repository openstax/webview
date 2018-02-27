# Representation of individual nodes in a book's tree (table of contents).
# A Node can represent both a tree (section), or leaf (page).
# Page Nodes also are used to cache a page's content once loaded.

define (require) ->
  $ = require('jquery')
  Backbone = require('backbone')
  settings = require('settings')
  linksHelper = require('cs!helpers/links')
  require('backbone-associations')
  session = require('cs!session')

  archiveport = if settings.cnxarchive.port then ":#{settings.cnxarchive.port}" else ''
  ARCHIVE = "#{location.protocol}//#{settings.cnxarchive.host}#{archiveport}"
  authoringport = if settings.cnxauthoring.port then ":#{settings.cnxauthoring.port}" else ''
  AUTHORING = "#{location.protocol}//#{settings.cnxauthoring.host}#{authoringport}"

  return class Node extends Backbone.AssociatedModel
    eTag: null
    defaults:
      visible: true

    # url: () -> "#{SERVER}/contents/#{@id}"
    url: () ->
      id = @getVersionedId()

      if @isNew()
        url = "#{AUTHORING}/users/contents"
      else if @isDraft()
        url = "#{AUTHORING}/contents/#{id}.json" # FIX: Remove .json from URL
      else if @get('book')?.isDraft()
        url = "#{ARCHIVE}/contents/#{id}.json"
      else if @isInBook()
        book = @get('book')
        url = "#{ARCHIVE}/contents/#{book.getVersionedId()}:#{id}.json"
      else
        url = "#{ARCHIVE}/contents/#{id}.json"

      return url

    parse: (response, options = {}) ->
      # Don't overwrite the title from the book's table of contents
      #if @get('title') then delete response.title
      response.title = @get('title') or response.title

      # extract abstract from wrapper
      if response.abstract?
        response.abstract = $(response.abstract).unwrap().html()

      if response.mediaType is 'application/vnd.org.cnx.collection'
        # Only load the contents once
        response.contents = @get('contents') or response.tree.contents or []

      else if response.mediaType is 'application/vnd.org.cnx.module'
        # FIX: cnx-authoring should not return a null value for content
        response.content = response.content or ''

        # jQuery can not build a jQuery object with <head> or <body> tags,
        # and will instead move all elements in them up one level.
        # Use a regex to extract everything in the body and put it into a div instead.
        $body = $('<div>' + response.content.replace(/^[\s\S]*<body.*?>|<\/body>[\s\S]*$/g, '') + '</div>')
        $body.children('[data-type=document-title]').eq(0).remove()
        $body.children('[data-type=abstract]').eq(0).remove()

        response.content = $body.html()

      return response

    fetch: (options = {}) ->
      if @isDraft()
        options.xhrFields = _.extend({withCredentials: true}, options.xhrFields)
        ###
        if @eTag
          options.headers ?= {}
          options.headers['If-None-Match'] = @eTag
        ###

      results = super(options)
      ###
      results.then () =>
        newETag = results.getResponseHeader('ETag')
        if @eTag and newETag isnt @eTag
          @set('changed-remotely', true)
        @eTag = newETag
      ###

      @set('downloads', 'loading')

      results.then () =>
        if @id and not options.skipDownloads
          if @isDraft() or not @get('version') # HACK for Untitled page
            @set('downloads', [])
            @set('isLatest', true)
          else
            $.ajax
              url: "#{ARCHIVE}/extras/#{@getVersionedId()}"
              dataType: 'json'
            .done (response) =>
              @set('downloads', response.downloads)
              @set('isLatest', response.isLatest)
              @set('canPublish', response.canPublish)
              @set('booksContainingPage', response.books)
              console.log(response)
            .fail () =>
              @set('downloads', [])

      return results

    save: (key, val, options) ->
      if not key? or typeof key is 'object'
        attrs = key
        options = val
      else
        attrs = {}
        attrs[key] = val

      options = _.extend(
        xhrFields:
          withCredentials: true
        excludeTransient: true # Remove transient properties before saving to the server
      , options)

      # Only save models that have changed
      if @get('changed') or @isNew()
        xhr = super(attrs, options).done () => @set('changed', false)
      else
        xhr = $.Deferred().resolve().promise()

      return xhr

    get: (attr) ->
      response = super(arguments...)

      if response is undefined
        switch attr
          when 'depth'
            response = @attributes['_parent']?.get('depth')
            if response isnt undefined then response++
            @set('depth', response)
          when 'book'
            response = @attributes['_parent']?.get('book')
            @set('book', response)

      return response

    containers: ->
      result = []
      parent = @get('_parent')
      while parent?.isSection()
        result.push(parent)
        parent = parent.get('_parent')
      result

    toJSON: (options = {}) ->
      results = super(arguments...)

      results.id = @getVersionedId()

      # FIX: Move all transient properties under 'meta'
      if options.excludeTransient
        delete results.loaded
        delete results.currentPage
        delete results._parent
        delete results.book
        delete results.type
        delete results.depth
        delete results.page
        delete results.changed
        delete results.active
        delete results.editable

      if options.derivedOnly
        results = {derivedFrom: results.derivedFrom}

      return results

    editOrDeriveContent: (options = {}, data) ->
      $.ajax
        type: 'POST'
        dataType: 'json'
        xhrFields:
          withCredentials: true
        url: "#{AUTHORING}/users/contents"
        data: data
      .done (response) ->
        options.success?(response)

    #
    # Utility Methods
    #

    _getIdComponents: -> @id?.match(///^#{linksHelper.contentPattern}///)

    getVersionedId: () ->
      components = @_getIdComponents() or []
      id = components[1] or ''
      version = @get('version') or components[2]
      if version then version = "@#{version}" else version = ''

      return "#{id}#{version}"

    getUuid: () ->
      components = @_getIdComponents() or []
      id = components[1] or ''

      return id

    getShortUuid: () ->
      id = @get('shortId') or @get('id')

      if typeof id is 'string'
        id = id.replace(/@.+/, '')

      return id

    index: () -> @get('_parent').get('contents').indexOf(@)

    getTotalLength: () -> 1

    getPageNumber: (model = @) -> 1 + model?.previousPageCount()

    # Determine if a model is an ancestor of this node
    hasAncestor: (model) ->
      parent = @get('_parent')

      if @ is model
        return false
      else if not parent
        return false
      else if parent is model
        return true
      else
        return parent.hasAncestor(model)

    previousPageCount: () ->
      parent = @get('_parent')

      if not parent then return 0

      contents = parent.get('contents').slice(0, @index())

      pages = _.reduceRight contents, ((memo, node) -> memo + node.getTotalLength()), 0

      if parent isnt @get('book')
        pages += parent.previousPageCount()

      return pages

    isCollated: () ->
      book = if @isBook() then @ else @get('book')
      collated = if book?.get('collated')? then book?.get('collated') else false
      return collated

    isSection: () -> not @isBook() and @get('contents') instanceof Backbone.Collection

    isBook: () -> @get('mediaType') is 'application/vnd.org.cnx.collection'

    isDraft: () -> @get('version') is 'draft' or /@draft$/.test(@id)

    isSaveable: () -> !!@get('mediaType')

    isEditable: () ->
      if not @get('loaded') and not @isSection()
        editable = false
      else if @get('editable')
        editable = true
      else if (@isDraft() or @isSection()) and @get('_parent')?.isEditable()
        editable = true
      else
        editable = false

      return editable

    isInBook: () -> !!@get('book')

    isCcap: ->
      book = if @isBook() then @ else @get('book')
      book?.get('printStyle')?.match(/^ccap-/)?

    canEdit: () ->
      if @get('loaded') and not @isDraft() and @get('canPublish') isnt undefined
        canPublish = @get('canPublish').toString()
        if canPublish.indexOf(session.get('id')) >= 0
          return true
