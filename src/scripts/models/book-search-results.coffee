define (require) ->
  Backbone = require('backbone')
  settings = require('json!settings.json')

  archiveport = if settings.cnxarchive.port then ":#{settings.cnxarchive.port}" else ''
  SEARCH_URI = "#{location.protocol}//#{settings.cnxarchive.host}#{archiveport}/search"

  return new class BookSearchResults extends Backbone.Model
    url: () -> "#{SEARCH_URI}/#{@bookId}?#{@query}"

    fetch: (options) ->
      @bookId = options.bookId
      @query = "q=#{options.query}"
      return super()
