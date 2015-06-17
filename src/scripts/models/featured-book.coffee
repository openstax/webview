define (require) ->
  Backbone = require('backbone')

  return class Book extends Backbone.Model
    defaults:
      title: 'Untitled Book'
      description: 'This book has no description.'
      cover: '/images/books/default.png'
      version: ''
      legacy_id: ''
      legacy_version: ''
      type: ''
      id: ''
      link: ''
