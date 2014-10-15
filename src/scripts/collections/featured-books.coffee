define (require) ->
  Backbone = require('backbone')
  FeaturedBook = require('cs!models/featured-book')
  $ = require('jquery')

  return new class FeaturedBooks extends Backbone.Collection
    url: 'http://devarchive.cnx.org/extras'
    model: FeaturedBook

    parse: (response) ->
      featuredLinks = response.featuredLinks
      books = featuredLinks
      #_.shuffle(featuredLinks) <-- not working ??
      @featuredBooks(books)
      return books

      #openStaxBooks = _.where(featuredLinks,{type: 'OpenStax Featured'})
      #@featuredBooks(openStaxBooks)
      #return openStaxBooks

      #cnxBooks = _.where(featuredLinks,{type:'CNX Featured'})
      #@featuredBooks(cnxBooks)
      #return cnxBooks


    initialize: () ->
      @fetch({reset: true})


    featuredBooks: (list) ->
      _.each list, (book) ->
        book.title = book.title
        book.description = () ->
          abstract = book.abstract
          truncatedText = $(abstract).text().substring(0,175) + '...'
          return truncatedText
        book.cover = book.resourcePath
        book.link = '/contents/' + book.id
