define (require) ->
  Backbone = require('backbone')
  settings = require('cs!settings')

  SEARCH_URI = "#{location.protocol}//#{settings.cnxarchive.host}:#{settings.cnxarchive.port}/search"

  FILTER_NAMES = {
    "author": "Author"
    "authorID": "Author"
    "keyword": "Keyword"
    "mediaType": "Type"
    "type": "Type"
    "pubYear": "Publication Date"
    "subject": "Subject"
    "title": "Title"
    "text": "Text"
  }

  return class SearchResults extends Backbone.Model
    url: () -> "#{SEARCH_URI}#{@query}"

    defaults:
      query:
        limits: []
        sort: []
      results:
        items: []
        total: 0

    initialize: (options = {}) ->
      @query = options.query or ''
      @fetch
        success: () => @set('loaded', true)

    parse: (response, options) ->
      response = super(arguments...)

      authors = new Backbone.Collection(response.results.auxiliary.authors)
      types = new Backbone.Collection(response.results.auxiliary.types)

      # Add natural language translation alongside tags
      _.each response.query.limits, (limit) ->
        limit.name = FILTER_NAMES[limit.tag]

      # Substitute author IDs in results with author objects
      _.each response.results.items, (item) ->
        _.each item.authors, (author, index) ->
          item.authors[index] = authors.get(author).toJSON()

      _.each response.results.limits, (limit) ->
        limit.name = FILTER_NAMES[limit.tag] # Add natural language translation alongside tags

        if limit.tag is 'authorID'
          _.each limit.values, (value) ->
            author = authors.get(value.value).toJSON()
            value.displayValue = author.fullname

        else if limit.tag is 'type'
           _.each limit.values, (value) ->
             type = types.get(value.value).toJSON()
             value.displayValue = type.name
             value.value = type.name

      return response
