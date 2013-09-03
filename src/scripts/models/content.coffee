define (require) ->
  Backbone = require('backbone')

  MEDIA_TYPES =
    'application/vnd.org.cnx.collection' : 'book'
    'application/vnd.org.cnx.module': 'module'

  class CurrentPage extends Backbone.Model
    url: () -> "/content/#{@id}"

    defaults:
      title: 'Untitled'
      author:
        name: 'Unknown'
        email: '#'
      body: 'No content'

  return class Content extends Backbone.Model
    url: () -> "/content/#{@id}"

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
        @set('pages', @get('contents').length)
        @setPage(page or 1) # Default to page 1
      else
        currentPage = @get('currentPage')
        currentPage.id = @id
        currentPage.fetch()

    setPage: (num) ->
      if num < 1 then num = 1
      if num > @pages then num = @pages
      if not num then return

      @set('page', num)

      currentPage = @get('currentPage')
      currentPage.clear({silent: true}).set(currentPage.defaults) # Reset the current page
      contents = @get('contents')
      currentPage.id = contents[num-1].id
      currentPage.fetch
        success: (model, response, options) ->
          currentPage.set('title', contents[num-1].title) if contents[num-1].title

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
