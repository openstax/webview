define [
  'backbone'
  'cs!models/book'
], (Backbone, Book) ->

  return new class Library extends Backbone.Collection
    url: 'data/library.json'
    model: Book

    initialize: () ->
      @fetch({reset: true})
