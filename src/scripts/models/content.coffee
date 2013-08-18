define [
  'backbone'
], (Backbone) ->

  class CurrentPage extends Backbone.Model
    url: () -> return "/content/#{@id}"

    defaults:
      pageNumber: 1
      title: 'Untitled'
      author:
        name: 'Uknown'
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
        name: 'Uknown'
        email: '#'
      currentPage: new CurrentPage()

    toJSON: () ->
      currentPage = @get('currentPage').toJSON()
      json = super()
      json.currentPage = currentPage
      return json

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
