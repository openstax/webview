define [
  'jquery'
  'underscore'
  'backbone'
  'cs!models/book'
], ($, _, Backbone, Book) ->

  return new class Library extends Backbone.Collection
    url: 'data/library.json'
    model: Book

    initialize: () ->
      @fetch({reset: true})
