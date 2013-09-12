define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  Backbone = require('backbone')

  MEDIA_TYPES =
    'application/vnd.org.cnx.collection' : 'book'
    'application/vnd.org.cnx.module': 'module'

  CONTENT_URI = "#{location.protocol}//#{location.hostname}:6543/contents"

  class CurrentPage extends Backbone.Model
    url: () -> "#{CONTENT_URI}/#{@id}"

    defaults:
      title: 'Untitled'
      content: 'No content'

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
      author:
        name: 'Unknown'
        email: '#'
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

      _.each @get('tree').contents, (item, index, contents) ->
        if item.contents
          _.each item.contents, (module, ind, subcol) ->
            module.parent = index # Module parents are numbered by their position in the tree
            toc.add(module)
        else
          toc.add(item)

      @set('toc', toc)
      @set('pages', toc.models.length)

    setPage: (num) ->
      if num < 1 then num = 1
      if num > @pages then num = @pages
      if not num then return

      @set('page', num)

      num-- # Page numbers begin at 1, but arrays begin at 0
      currentPage = @get('currentPage')
      currentPage.clear({silent: true}).set(currentPage.defaults) # Reset the current page
      contents = @get('toc').at(num).toJSON()
      currentPage.id = contents.id
      currentPage.fetch()
        #success: (model, response, options) ->
          #currentPage.set('title', contents[num].title) if contents[num].title

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
