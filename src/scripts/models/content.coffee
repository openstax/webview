define (require) ->
  _ = require('underscore')
  Backbone = require('backbone')
  settings = require('settings')
  Collection = require('cs!models/contents/collection')
  Page = require('cs!models/contents/page')

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

    save: () ->
      # FIX: Pass the proper arguments to super

      options =
        includeTree: true
        excludeContents: true

      if arguments[0]? or not _.isObject(arguments[0])
        arguments[1] = _.extend(options, arguments[1])
      else
        arguments[2] = _.extend(options, arguments[2])

      return super(null, options)

    toJSON: (options = {}) ->
      results = super(arguments...)

      if options.includeTree and @isBook()
        results.tree =
          id: @getVersionedId()
          title: @get('title')
          contents: @get('contents')?.toJSON?({serialize_keys: ['id', 'title', 'contents']}) or []

      if options.excludeContents
        delete results.contents

      return results

    load: (page) ->
      if @isBook()
        if @get('contents').length
          @setPage(page or 1) # Default to page 1

    fetchPage: () ->
      page = @get('currentPage')
      page.fetch().done () =>
        page.set('loaded', true)

    setPage: (num) ->
      pages = @getTotalPages()

      if num < 1 then num = 1
      if num > pages then num = pages

      page = @getPage(num)
      @get('currentPage')?.set('active', false)
      @set('currentPage', page)
      page.set('active', true)

      if not page.get('loaded')
        @fetchPage()

    getTotalPages: () ->
      # FIX: cache total pages and recalculate on add/remove events?
      return @getTotalLength()

    getPageNumber: (model = @get('currentPage')) -> super(model)

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

    removeNode: (node) ->
      # FIX: get previous page even if removing a section
      #previousPage = @getPageNumber(@getPreviousNode(node))
      previousPage = @getPageNumber(node) - 1

      node.get('parent').get('contents').remove(node)

      # FIX: determine if node was inside a section that got removed too
      if node is @get('currentPage')
        @setPage(previousPage)

      @trigger('removeNode')

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
