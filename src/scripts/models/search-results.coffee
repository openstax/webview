define (require) ->
  Backbone = require('backbone')
  settings = require('settings')

  SEARCH_URI = "#{location.protocol}//#{settings.cnxarchive.host}:#{settings.cnxarchive.port}/search"

  FILTER_NAMES = {
    "author": "Author"
    "authorID": "Author"
    "keyword": "Keyword"
    "language": "Language"
    "mediaType": "Type"
    "type": "Type"
    "pubYear": "Publication Date"
    "subject": "Subject"
    "title": "Title"
    "text": "Text"
  }

  return new class SearchResults extends Backbone.Model
    url: () -> "#{SEARCH_URI}#{@query}"

    defaults:
      query:
        limits: []
        sort: []
      results:
        items: []
        total: 0
        auxiliary:
          authors: []
          types: []

    initialize: (options = {}) ->
      @query = options.query or ''

    load: (query) ->
      if query isnt @query
        # Reset search results
        @clear().set(@defaults)
        @set('loaded', false)

        @query = query or ''
        @fetch
          success: () =>
            @set('error', false)
          error: (model, response, options) =>
            @set('error', response.status)
        .always () =>
          @set('loaded', true)

      return @

    parse: (response, options) ->
      response = super(arguments...)

      response.results.auxiliary or= {}

      authors = new Backbone.Collection(response.results.auxiliary.authors)
      types = new Backbone.Collection(response.results.auxiliary.types)

      # Add natural language translation alongside tags
      _.each response.query.limits, (limit) ->
        limit.name = FILTER_NAMES[limit.tag]

        if limit.tag is 'authorID'
          limit.name = 'Author ID'
          author = authors.get(limit.value).toJSON()
          limit.displayValue = "#{author.fullname} (#{author.id})"

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
