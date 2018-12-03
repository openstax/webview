define (require) ->
  $ = require('jquery')
  Backbone = require('backbone')
  settings = require('json!settings.json')
  FeaturedBook = require('cs!models/featured-book')

  archiveport = if settings.cnxarchive.port then ":#{settings.cnxarchive.port}" else ''
  archive = "#{location.protocol}//#{settings.cnxarchive.host}#{archiveport}"

  return new class FeaturedCnxBooks extends Backbone.Collection
    url: "#{archive}/extras/featured"
    model: FeaturedBook

    parse: (response) ->
      books = _.filter response.featured, (book) ->
        book.type == 'CNX Featured'

      _.each books, (book) ->
        book.title = book.title
        book.description = () ->
          abstract = book.abstract
          if abstract isnt null
            return $(abstract).text()
          else
            return ''
        book.cover = "#{archive}#{book.resourcePath}"
        book.link = "contents/#{book.id}"

      return books


    initialize: () ->
      @fetch({reset: true})
