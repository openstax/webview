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
    url: () -> "#{@searchUrl}#{@query}"

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

    initialize: (options) ->
      @config(options)
      @set('loaded', false)

    config: (options = {}) ->
      @query = options.query or ''
      @searchUrl = options.url or SEARCH_URI

      return @

    load: (options) ->
      query = options.query or @query
      url = options.url or @searchUrl

      if query isnt @query or url isnt @searchUrl
        @config(options)
        @fetch(options)

      return @

    fetch: () ->
      # Reset search results
      @clear({silent: true}).set(@defaults)
      @set('loaded', false)

      return super(arguments...)
      .always () =>
        @set('loaded', true)
      .done () =>
        @set('error', false)
      .fail (model, response, options) =>
        @set('error', response.status)

    parse: (response, options) ->
      response = super(arguments...)

      response.results.auxiliary or= {}

      authors = response.results.auxiliary.authors
      types = new Backbone.Collection(response.results.auxiliary.types)

      # Add natural language translation alongside tags
      _.each response.query.limits, (limit) ->
        limit.name = FILTER_NAMES[limit.tag]

        if limit.tag is 'authorID'
          limit.name = 'Author ID'
          author = authors[limit.index]
          limit.displayValue = "#{author.fullname} (#{author.id})"

      _.each response.results.limits, (limit) ->
        limit.name = FILTER_NAMES[limit.tag] # Add natural language translation alongside tags

        if limit.tag is 'authorID'
          _.each limit.values, (value) ->
            author = authors[value.index]
            value.displayValue = author.fullname

        else if limit.tag is 'type'
          _.each limit.values, (value) ->
            type = types.get(value.value).toJSON()
            value.displayValue = type.name
            value.value = type.name

      return response

    # Used when adding new content from the Workspace
    prependNew: (content) ->
      @get('results').items.unshift(content.toJSON())
      @trigger('change:results')
      @trigger('change')
