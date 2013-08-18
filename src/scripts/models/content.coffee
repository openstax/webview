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
      pages: 315
      author:
        name: 'Uknown'
        email: '#'
      currentPage: new CurrentPage()

    toJSON: () ->
      currentPage = @get('currentPage').toJSON()
      json = super()
      json.currentPage = currentPage
      return json
