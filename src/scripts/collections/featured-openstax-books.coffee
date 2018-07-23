define (require) ->
  $ = require('jquery')
  Backbone = require('backbone')
  settings = require('settings')
  FeaturedBook = require('cs!models/featured-book')

  openstaxcmsport = if settings.openstaxcms.port then ":#{settings.openstaxcms.port}" else ''
  openstaxcms = "#{location.protocol}//#{settings.openstaxcms.host}#{openstaxcmsport}"

  return new class FeaturedOpenStaxBooks extends Backbone.Collection
    url: "#{openstaxcms}/api/v2/pages/?type=books.Book&limit=250" +
         "&fields=cover_url,description,title,cnx_id"
    model: FeaturedBook

    parse: (response) ->
      books = response.items

      _.each books, (book) ->
        book.cover = book.cover_url
        book.description = $(book.description).text()
        book.link = "#{location.protocol}//#{location.host}/contents/#{book.cnx_id}"
        book.type = 'OpenStax Featured'
        book.id = book.id.toString()

      return books


    initialize: () ->
      @fetch({reset: true})
