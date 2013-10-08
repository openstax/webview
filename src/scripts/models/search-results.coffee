define (require) ->
  Backbone = require('backbone')

  SEARCH_URI = "#{location.protocol}//#{location.hostname}:6543/search"

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
