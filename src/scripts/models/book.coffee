define [
  'jquery'
  'underscore'
  'backbone'
], ($, _, Backbone) ->

  return class Book extends Backbone.Model
    defaults:
      title: 'Untitled Book'
      cover: '/images/books/default.png'
      description: 'This book has no description.'
