define (require) ->
  _ = require('underscore')
  Backbone = require('backbone')
  settings = require('settings')
  Collection = require('cs!models/contents/collection')
  Page = require('cs!models/contents/page')

  MEDIA_TYPES =
    'application/vnd.org.cnx.collection' : 'book'
    'application/vnd.org.cnx.module': 'page'

  return class Content extends Collection
    relations: [{
      type: Backbone.Many
      key: 'contents'
      relatedModel: (relation, attributes) ->
        return (attrs, options) =>
          # FIX: Consider putting all added fields under _meta to make removal before saving simple
          attrs.parent = @
          attrs.depth = 0
          attrs.book = @
          if _.isArray(attrs.contents)
            delete attrs.id # Get rid of the 'subcol' id so the section is unique
            return new Collection(attrs)

          return new Page(attrs)
    }, {
      type: Backbone.Many
      key: 'authors'
      collectionType: () -> Backbone.Collection
    }, {
      type: Backbone.One
      key: 'currentPage'
      relatedModel: Page
    }]

    initialize: (options = {}) ->
      @set('loaded', false)
      @fetch
        reset: true
      .always () =>
        @set('loaded', true)
      .done () =>
        @set('error', false)
        @load(options.page)
      .fail (model, response, options) =>
        @set('error', response.status)

    parse: (response) ->
      type = response.type = MEDIA_TYPES[response.mediaType]

      if type isnt 'book' then return response

      response.contents = response.tree.contents or []

      return response

    load: (page) ->
      if @get('type') is 'book'
        if @get('contents').length
          @setPage(page or 1) # Default to page 1
        else
          @trigger('changePage') # Don't setup an empty book
      else
        @set('currentPage', new Page(@toJSON(), {parse: true}))
        @trigger('changePage')

    fetchPage: () ->
      page = @get('currentPage')
      page.fetch
        success: () =>
          page.set('loaded', true)
          @trigger('changePage')

    setPage: (num) ->
      pages = @getTotalPages()

      if num < 1 then num = 1
      if num > pages then num = pages

      page = @getPage(num)
      @get('currentPage')?.set('active', false)
      @set('currentPage', page)
      page.set('active', true)
      @trigger('changePage')

      if not page.get('loaded')
        @fetchPage()

    getTotalPages: () ->
      # FIX: cache total pages and recalculate on add/remove events?
      @getTotalLength()

    getPageNumber: (model = @get('currentPage')) -> super(model)

    removeNode: (node) ->
      # FIX: get previous page even if removing a section
      #previousPage = @getPageNumber(@getPreviousNode(node))
      previousPage = @getPageNumber(node) - 1

      node.get('parent').get('contents').remove(node)

      # FIX: determine if node was inside a section that got removed too
      if node is @get('currentPage')
        @setPage(previousPage)

      @trigger('removeNode')

    getNextPage: () ->
      if not @get('loaded') then return 0
      pages = @getTotalPages()

      page = @getPageNumber()
      if page < pages then ++page
      return page

    getPreviousPage: () ->
      if not @get('loaded') then return 0
      page = @getPageNumber()
      if page > 1 then --page
      return page

    nextPage: () ->
      page = @getPageNumber()
      nextPage = @getNextPage()

      # Show the next page if there is one
      @setPage(nextPage) if page isnt nextPage

      return nextPage

    previousPage: () ->
      page = @getPageNumber()
      previousPage = @getPreviousPage()

      # Show the previous page if there is one
      @setPage(previousPage) if page isnt previousPage

      return previousPage

    move: (node, marker, position) ->
      oldContainer = node.get('parent')
      container = marker.get('parent')

      # Prevent a node from trying to become its own ancestor (infinite recursion)
      if marker.hasAncestor(node)
        return node

      # Remove the node
      oldContainer.get('contents').remove(node)

      if position is 'insert'
        index = 0
        container = marker
      else
        index = marker.index()
        if position is 'after' then index++

      # Mark the node's parent, node's old parent, and book as changed
      oldContainer.set('changed', true)
      container.set('changed', true)
      @set('changed', true)

      # Re-add the node in the correct position
      container.get('contents').add(node, {at: index})

      # Update the node's parent
      node.set('parent', container)

      # Update the node's depth
      if container.has('depth')
        node.set('depth', 1 + container.get('depth'))
      else
        node.set('depth', 0)

      @trigger('moveNode')
      return node

    isSection: () -> return false

    toJSON: (options = {}) ->
      # FIX: Only calculate tree if specific option is set
      # FIX: Refactor code, move as much as possible into collection.coffee and node.coffee
      # FIX: id@version is not being set properly on loaded modules in subcollections
      # FIX: Saves are currently going to cnxarchive instead of cnxauthoring
      # FIX: Only save models that have changed

      results = super(arguments...)

      components = @get('id')?.match(/([^:@]+)@?([^:]*)/) or []
      id = components[1]
      version = @get('version') or components[2]

      results.version = 'draft'

      results.tree =
        id: "#{id}@draft"
        title: @get('title')
        contents: []

      _.each @get('contents')?.models, (model) ->
        if model.id
          version = model.get('version')
          if version
            id = "#{id}@#{version}"
          else
            id = model.id
        else
          id = 'subcol'
        title = model.get('title')

        obj =
          id: id
          title: title

        if options.simplified
          options = _.extend({serialize_keys: ['id', 'title', 'contents']}, options)
        contents = model.get('contents')?.toJSON?(options)
        if contents
          obj.contents = contents

        results.tree.contents.push(obj)

      return results
