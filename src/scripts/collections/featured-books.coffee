define (require) ->
  $ = require('jquery')
  Backbone = require('backbone')
  settings = require('settings')
  FeaturedBook = require('cs!models/featured-book')

  archive = "#{location.protocol}//#{settings.cnxarchive.host}:#{settings.cnxarchive.port}"

  return new class FeaturedBooks extends Backbone.Collection
    url: "#{archive}/extras"
    model: FeaturedBook

    parse: (response) ->
      books = response.featuredLinks

      _.each books, (book) ->
        book.title = book.title
        book.description = () ->
          abstract = book.abstract
          abstractText = $(abstract).text().substring(0,100)+'...'
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
