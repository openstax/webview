define (require) ->
  $ = require('jquery')
  Backbone = require('backbone')
  settings = require('settings')
  FeaturedBook = require('cs!models/featured-openstax-book')

  openstaxcmsport = if settings.openstaxcms.port then ":#{settings.openstaxcms.port}" else ''
  openstaxcms = "#{location.protocol}//#{settings.openstaxcms.host}#{openstaxcmsport}"

  return new class FeaturedOpenStaxBooks extends Backbone.Collection
    url: "#{openstaxcms}/api/v2/pages/?type=books.Book&limit=250" +
         "&fields=cover_url,description,title,cnx_id"
    model: FeaturedBook

    parse: (response) -> response.items

    initialize: () ->
      @fetch({reset: true})
