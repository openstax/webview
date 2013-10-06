define (require) ->
  Backbone = require('backbone')
  settings = require('cs!settings')
  Collection = require('cs!models/content/collection')
  Page = require('cs!models/content/page')
  require('backbone-associations')

  MEDIA_TYPES =
    'application/vnd.org.cnx.collection' : 'book'
    'application/vnd.org.cnx.module': 'page'

  CONTENT_URI = "#{location.protocol}//#{settings.cnxarchive.host}:#{settings.cnxarchive.port}/contents"

  return class Content extends Backbone.AssociatedModel
    url: () -> "#{CONTENT_URI}/#{@id}"

    defaults:
      title: 'Untitled Book'
      pages: 1
      authors: []

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
      collectionType: Backbone.Collection
    }, {
      type: Backbone.One
      key: 'currentPage'
      relatedModel: Page
    }, {
      type: Backbone.Many
      key: 'toc'
      collectionType: Backbone.Collection
    }]

    parse: (response) ->
      type = response.type = MEDIA_TYPES[response.mediaType]

      # Keep the id with the desired version number included
      delete response.id

      if type isnt 'book' then return response

      response.contents = response.tree.contents

      depth = 0
      page = 1

      # Traverse a book's tree and set book, depth, unit, parent, subcollection, and page
      # information on each node of the tree prior to the tree being processed
      # by backbone-associations.
      traverse = (o = {}) =>
        for item, index in o.contents
          item.book = @
          item.depth = depth

          if depth
            item.parent = o
            item.unit = "#{o.unit}-#{index+1}"
          else
            item.unit = "#{index+1}"

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

    initialize: (options = {}) ->
      @set('toc', [])
      @fetch
        success: () => @load(options.page)

    load: (page) ->
      if @get('type') is 'book'
        toc = @get('toc')
        for i in [0..@get('pages')] by 1
          toc.add(@findPage(i+1))

        @setPage(page or 1) # Default to page 1
      else
        @set('currentPage', new Page({id: @id}))
        @get('currentPage').fetch()

    findPage: (num) ->
      search = (contents) ->
        for item in contents.models
          if item.get('page') is num
            return item
          else if item.get('contents')
            result = search(item.get('contents'))
            return result if result
        return

      return search(@get('contents'))

    setPage: (num) ->
      if num < 1 then num = 1
      if num > @pages then num = @pages

      @set('page', num)

      page = @get('toc').at(num-1)
      @get('currentPage')?.set('active', false)
      @set('currentPage', page)
      page.set('active', true)

      if not page.loaded
        page.fetch
          success: () -> page.loaded = true

    nextPage: () ->
      page = @get('page')

      # Show the next page if there is one
      if page < @get('pages')
        @setPage(++page)

      return page

    previousPage: () ->
      page = @get('page')

      # Show the previous page if there is one
      if page isnt 1
        @setPage(--page)

      return page
