define (require) ->
  Backbone = require('backbone')
  FeaturedBook = require('cs!models/featured-book')
  $ = require('jquery')
  settings = require('settings')

  archive = "#{location.protocol}//#{settings.cnxarchive.host}" #Change this in settings.js for development purposes - devarchive.cnx.org

  return new class FeaturedBooks extends Backbone.Collection
    url: "#{archive}/extras"
    model: FeaturedBook

    parse: (response) ->
      books = response.featuredLinks

      _.each books, (book) ->
        book.title = book.title
        book.description = () ->
          abstract = book.abstract
          abstractText = $(abstract).text().substring(0,175)+'...'
          if abstract isnt null
           return "#{abstractText}"
          else
           return ''
        book.cover = "#{archive}#{book.resourcePath}"
        book.link = "contents/#{book.id}"

      featuredLinks = _.shuffle(books)
      return featuredLinks


    initialize: () ->
      @fetch({reset: true})
