define (require) ->
  Backbone = require('backbone')
  settings = require('settings')

  openstaxcmsport = if settings.openstaxcms.port then ":#{settings.openstaxcms.port}" else ''
  openstaxcms = "#{location.protocol}//#{settings.openstaxcms.host}#{openstaxcmsport}"

  return class Book extends Backbone.Model
    url: () -> "#{openstaxcms}/api/v2/pages/?type=books.Book&limit=250" +
      "&fields=cover_url,description,title,cnx_id" +
      "&cnx_id=#{@get('cnx_id')}"

    parseDescription: (desc) ->
      if !desc 
        'This book has no description.'
      else
        desc.replace(/<(?:[^a.]|\s)*?>/g, "")

    parse: (response, options) ->
      data = if response.items then response.items[0] else response
      parsed =
        title: data?.title
        description: @parseDescription(data?.description)
        cover: data?.cover_url
        type: 'OpenStax Featured'
        id: data?.id.toString()
        link: "contents/#{data?.cnx_id}"
        cnx_id: data?.cnx_id
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
      cnx_id: ''
