define [
  'backbone'
], (Backbone) ->

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
      page: 1
      author:
        name: 'Unknown'
        email: '#'
      currentPage: new CurrentPage()

    toJSON: () ->
      currentPage = @get('currentPage').toJSON()
      json = super()
      json.currentPage = currentPage
      return json

    initialize: () -> @fetch
      success: (model, response, options) => @setup()

    setup: () ->
      @set('type', MEDIA_TYPES[@get('mediaType')])
      @set('pages', @get('contents').length)
      @setPage(1)

    setPage: (num) ->
      if num < 1 then num = 1
      if num > @pages then num = @pages
      if not num then return

      @set('page', num)

      currentPage = @get('currentPage')
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
        @setPage(page+1)

    previousPage: () ->
      currentPage = @get('currentPage')
      page = @get('page')

      # Show the previous page if there is one
      if page isnt 1
        @setPage(page-1)
