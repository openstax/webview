define (require) ->
  Backbone = require('backbone')
  FeaturedBook = require('cs!models/featured-book')

  return new class FeaturedBooks extends Backbone.Collection
    url: 'data/featured-books.json'
    model: FeaturedBook

    initialize: () ->
      @fetch({reset: true})
