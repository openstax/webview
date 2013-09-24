define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  Backbone = require('backbone')
  settings = require('cs!settings')

  MEDIA_TYPES =
    'application/vnd.org.cnx.collection' : 'book'
    'application/vnd.org.cnx.module': 'page'

  CONTENT_URI = "#{location.protocol}//#{settings.cnxarchive.host}:#{settings.cnxarchive.port}/contents"

  class CurrentPage extends Backbone.Model
    url: () -> "#{CONTENT_URI}/#{@id}"

    defaults:
      title: 'Untitled'
      content: 'No content'
      authors: []

    parse: (response, options) ->
      # jQuery can not build a jQuery object with <head> or <body> tags,
      # and will instead move all elements in them up one level.
      # Use a regex to extract everything in the body and put it into a div instead.
      $body = $('<div>' + response.content.replace(/^[\s\S]*<body.*?>|<\/body>[\s\S]*$/g, '') + '</div>')
      $body.find('.title').eq(0).remove()
      response.content = $body.html()

      return response

  return class Content extends Backbone.Model
    url: () -> "#{CONTENT_URI}/#{@id}"

    defaults:
      title: 'Untitled Book'
      pages: 1
      authors: []
      currentPage: new CurrentPage()

    toJSON: () ->
      currentPage = @get('currentPage').toJSON()
      json = super()
      json.currentPage = currentPage
      return json

    initialize: (options = {}) ->
      @fetch
        success: () => @setup(options.page)

    setup: (page) ->
      type = MEDIA_TYPES[@get('mediaType')]
      @set('type', type)

      if type is 'book'
        @setupToc()
        @setPage(page or 1) # Default to page 1
      else
        currentPage = @get('currentPage')
        currentPage.id = @id
        currentPage.fetch()

    # Create a flat collection to store all the pages
    setupToc: () ->
      toc = new Backbone.Collection()
      index = 0

      traverse = (o, sub) ->
        if typeof o isnt 'object' then return
        for item in o.contents
          if item.contents
            traverse(item, true)
            index++
          else
            if sub then item.parent = index # Item parents are numbered by their position in the tree
            toc.add(item)

      traverse(@get('tree'))
      @set('toc', toc)
      @set('pages', toc.models.length)

    setPage: (num) ->
      if num < 1 then num = 1
      if num > @pages then num = @pages
      if not num then return

      @set('page', num)

      currentPage = @get('currentPage')
      currentPage.clear({silent: true}).set(currentPage.defaults) # Reset the current page
      contents = @get('toc').at(num-1).toJSON()
      currentPage.id = contents.id
      currentPage.fetch
        success: (model, response, options) ->
          currentPage.set('title', contents.title) if contents.title

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
