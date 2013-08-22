define [
  'backbone'
  'cs!models/featured-book'
], (Backbone, FeaturedBook) ->

  return new class FeaturedBooks extends Backbone.Collection
    url: 'data/featured-books.json'
    model: FeaturedBook

    initialize: () ->
      @fetch({reset: true})
