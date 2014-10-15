define (require) ->
  Backbone = require('backbone')
  FeaturedBook = require('cs!models/featured-book')
  $ = require('jquery')
  settings = require('settings')

  return new class FeaturedBooks extends Backbone.Collection
    url: settings.cnxarchive + '/extras' # Change this in settings.js for development purposes - devarchive.cnx.org
    model: FeaturedBook

    parse: (response) ->
      books = response.featuredLinks

      _.each books, (book) ->
        book.title = book.title
        book.description = () ->
          abstract = book.abstract
          truncatedText = $(abstract).text().substring(0,175) + '...'
          return truncatedText
        book.cover = settings.devArchive + book.resourcePath
        book.link =  '/contents/' + book.id

      featuredLinks = _.shuffle(books)
      return featuredLinks


    initialize: () ->
      @fetch({reset: true})
