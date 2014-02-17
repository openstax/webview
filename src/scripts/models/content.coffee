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
        return (attrs, options) ->
          if _.isArray(attrs.contents)
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

      response.contents = response.tree.contents

      depth = 0
      page = 1

      # Traverse a book's tree and set book, depth, parent, subcollection, and page
      # information on each node of the tree prior to the tree being processed
      # by backbone-associations.
      traverse = (o = {}) =>
        for item in o.contents
          item.book = @
          item.depth = depth
          item.parent = o

          # Determine if the item is a subcollection or a page
          if item.contents
            item.subcollection = true
            delete item.id # Get rid of the 'subcol' id so the subcollection is unique
            depth++
            traverse(item)
          else
            item.page = page++

        depth--

      traverse(response.tree)

      # Total number of pages in the book
      response.pages = page - 1

      return response

    load: (page) ->
      if @get('type') is 'book'
        @setPage(page or 1) # Default to page 1
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
