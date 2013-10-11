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
