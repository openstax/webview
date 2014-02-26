define (require) ->
  _ = require('underscore')
  Backbone = require('backbone')
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
            attrs.subcollection = true
            delete attrs.id # Get rid of the 'subcol' id so the subcollection is unique
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
        success: () =>
          @set('error', false)
          @load(options.page)
        error: (model, response, options) =>
          @set('error', response.status)
      .always () =>
        @set('loaded', true)

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
          @trigger('changePage') # Don't setup an empty collection
      else
        @set('currentPage', new Page({id: @id}))
        @fetchPage()

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

    getPageNumber: (model = @get('currentPage')) -> 1 + model.previousPageCount()

    removeNode: (node) ->
      # FIX: get previous page even if removing a subcollection
      #previousPage = @getPageNumber(@getPreviousNode(node))
      previousPage = @getPageNumber(node) - 1

      node.get('parent').get('contents').remove(node)

      # FIX: determine if node was inside a subcollection that got removed too
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
