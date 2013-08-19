define [
  'backbone'
], (Backbone) ->

  class CurrentPage extends Backbone.Model
    url: () -> return "/content/#{@id}"

    defaults:
      pageNumber: 1
      title: 'Untitled'
      author:
        name: 'Unknown'
        email: '#'
      summary: 'No summary'
      body: 'No content'

  return class Content extends Backbone.Model
    url: () -> return "/content/#{@id}"

    defaults:
      title: 'Untitled Book'
      type: 'book'
      pages: 300
      author:
        name: 'Unknown'
        email: '#'
      currentPage: new CurrentPage()

    toJSON: () ->
      currentPage = @get('currentPage').toJSON()
      json = super()
      json.currentPage = currentPage
      return json

    initialize: () ->
      @fetch
        success: (model, response, options) =>
          currentPage = @get('currentPage')
          currentPage.id = response.contents[0].id
          currentPage.fetch()

    nextPage: () ->
      currentPage = @get('currentPage')
      pageNumber = currentPage.get('pageNumber')

      # Show the next page if there is one
      if pageNumber < @get('pages')
        currentPage.set('pageNumber', pageNumber+1)
        @trigger('change:currentPage')

    previousPage: () ->
      currentPage = @get('currentPage')
      pageNumber = currentPage.get('pageNumber')

      # Show the previous page if there is one
      if pageNumber isnt 1
        currentPage.set('pageNumber', pageNumber-1)
        @trigger('change:currentPage')
