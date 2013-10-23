define (require) ->
  Backbone = require('backbone')
  settings = require('cs!settings')

  SEARCH_URI = "#{location.protocol}//#{settings.cnxarchive.host}:#{settings.cnxarchive.port}/search"

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

      authors = new Backbone.Collection()
      _.each response.results.limits, (limit) ->
        if limit.author then authors.add(limit.author)

      _.each response.results.items, (item) ->
        _.each item.authors, (author, index) ->
          item.authors[index] = authors.get(author).toJSON()

      return response