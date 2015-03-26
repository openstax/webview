define (require) ->
  Backbone = require('backbone')
  FeaturedBook = require('cs!models/featured-book')

  archiveport = if settings.cnxarchive.port then ":#{settings.cnxarchive.port}" else ''
  archive = "#{location.protocol}//#{settings.cnxarchive.host}#{archiveport}"

  return new class FeaturedBooks extends Backbone.Collection
    url: 'data/featured-books.json'
    model: FeaturedBook

    initialize: () ->
      @fetch({reset: true})
