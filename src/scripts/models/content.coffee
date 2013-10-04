define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  Backbone = require('backbone')
  settings = require('cs!settings')
  require('backbone-associations')

  MEDIA_TYPES =
    'application/vnd.org.cnx.collection' : 'book'
    'application/vnd.org.cnx.module': 'page'

  CONTENT_URI = "#{location.protocol}//#{settings.cnxarchive.host}:#{settings.cnxarchive.port}/contents"

  class Toc extends Backbone.AssociatedModel
    relations: [{
      type: Backbone.Many
      key: 'contents'
      relatedModel: Toc
      parse: true
    }]

  return class Content extends Backbone.AssociatedModel
    url: () -> "#{CONTENT_URI}/#{@id}"

    defaults:
      title: 'Untitled Book'
      pages: 1
      authors: []
      currentPage: new Backbone.Model
        defaults:
          title: 'Untitled'
          content: 'No content'
          authors: []

    relations: [{
      type: Backbone.One
      key: 'tree'
      relatedModel: Toc
    }, {
      type: Backbone.Many
      key: 'authors'
      collectionType: Backbone.Collection
    }]

    toJSON: () ->
      currentPage = @get('currentPage')?.toJSON()
      toc = @get('toc').toJSON()
      json = super()
      json.currentPage = currentPage
      json.toc = toc
      return json

    parse: (response) ->
      type = MEDIA_TYPES[response.mediaType]
      toc = @get('toc')
      @set('type', type)

      if type isnt 'book' then return response

      depth = 0
      page = 1

      traverse = (o = {}, sub) =>
        for item, index in o.contents
          item.book = @
          item.depth = depth

          if depth
            item.parent = o
            item.unit = "#{o.unit}-#{index+1}"
          else
            item.unit = "#{index+1}"

          if item.contents
            item.subcollection = true
            delete item.id
            depth++
            traverse(item, true)
          else
            item.page = page++
            toc.add(item)

        depth--

      traverse(response.tree)

      @set('pages', page)

      return response

    initialize: (options = {}) ->
      window.x = @
      @set('toc', new Backbone.Collection())
      @fetch
        success: () => @load(options.page)

    load: (page) ->
      if @get('type') is 'book'
        @setPage(page or 1) # Default to page 1
      else
        @set('currentPage', new Toc({id: @id}))
        @get('currentPage').fetch()

    setPage: (num) ->
      if num < 1 then num = 1
      if num > @pages then num = @pages
      if not num then return

      @set('page', num)

      page = @get('toc').at(num-1)
      @get('currentPage')?.set('active', false)
      @set('currentPage', page)
      page.set('active', true)
      page.url = "#{CONTENT_URI}/#{page.id}"
      page.parse = (response, options) ->
        if not response.content then return response
        # jQuery can not build a jQuery object with <head> or <body> tags,
        # and will instead move all elements in them up one level.
        # Use a regex to extract everything in the body and put it into a div instead.
        $body = $('<div>' + response.content.replace(/^[\s\S]*<body.*?>|<\/body>[\s\S]*$/g, '') + '</div>')
        $body.find('.title').eq(0).remove()
        response.content = $body.html()

        return response

      if not page.loaded
        page.fetch
          success: () -> page.loaded = true

    nextPage: () ->
      currentPage = @get('currentPage')
      page = @get('page')

      # Show the next page if there is one
      if page < @get('pages')
        @setPage(++page)

      return page

    previousPage: () ->
      currentPage = @get('currentPage')
      page = @get('page')

      # Show the previous page if there is one
      if page isnt 1
        @setPage(--page)

      return page
