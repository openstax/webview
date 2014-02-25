define (require) ->
  Backbone = require('backbone')
  toc = require('cs!collections/toc')
  Collection = require('cs!models/contents/collection')
  Page = require('cs!models/contents/page')
  require('backbone-associations')

  MEDIA_TYPES =
    'application/vnd.org.cnx.collection' : 'book'
    'application/vnd.org.cnx.module': 'page'

  return class Content extends Collection
    relations: [{
      type: Backbone.Many
      key: 'contents'
      relatedModel: (relation, attributes) ->
        return (attrs, options) =>
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
    }, {
      type: Backbone.Many
      key: 'toc'
      collectionType: () -> Backbone.Collection
    }]

    initialize: (options = {}) ->
      toc.reset()
      @set('toc', toc)

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

      # Only setup a toc for a book
      if type isnt 'book' then return response

      response.contents = response.tree.contents or []

      return response

    load: (page) ->
      if @get('type') is 'book'
        @set('pages', @get('toc').length)
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
      if num < 1 then num = 1
      if num > @pages then num = @pages

      @set('page', num)

      page = @get('toc').at(num-1)
      @get('currentPage')?.set('active', false)
      @set('currentPage', page)
      page.set('active', true)
      @trigger('changePage')

      if not page.get('loaded')
        @fetchPage()

    getPageNumber: (model) -> @get('toc').indexOf(model) + 1

    removeNode: (node) ->
      page = @get('page')

      if @getPageNumber(node) < page
        @set('page', --page)

      @get('toc').remove(node)
      node.get('parent').get('contents').remove(node)

      @setPage(page)
      @trigger('removeNode')

    getNextPage: () ->
      page = @get('page')
      if page < @get('pages') then ++page
      return page

    getPreviousPage: () ->
      page = @get('page')
      if page > 1 then --page
      return page

    nextPage: () ->
      page = @get('page')
      nextPage = @getNextPage()

      # Show the next page if there is one
      @setPage(nextPage) if page isnt nextPage

      return nextPage

    previousPage: () ->
      page = @get('page')
      previousPage = @getPreviousPage()

      # Show the previous page if there is one
      @setPage(previousPage) if page isnt previousPage

      return previousPage
