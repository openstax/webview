define (require) ->
  $ = require('jquery')
  Backbone = require('backbone')
  settings = require('cs!settings')
  require('backbone-associations')

  CONTENT_URI = "#{location.protocol}//#{settings.cnxarchive.host}:#{settings.cnxarchive.port}/contents"

  return class Node extends Backbone.AssociatedModel
    url: () -> "#{CONTENT_URI}/#{@id}"
    defaults:
      authors: []

    parse: (response, options) ->
      # Don't overwrite the title from the book's table of contents
      if @get('title')
        delete response.title

      if not response.content then return response
      # jQuery can not build a jQuery object with <head> or <body> tags,
      # and will instead move all elements in them up one level.
      # Use a regex to extract everything in the body and put it into a div instead.
      $body = $('<div>' + response.content.replace(/^[\s\S]*<body.*?>|<\/body>[\s\S]*$/g, '') + '</div>')
      $body.find('.title').eq(0).remove()
      response.content = $body.html()

      return response

    relations: [{
      type: Backbone.Many
      key: 'contents'
      relatedModel: Node
    }]

    findPage: (num) ->
      search = (item) ->
        contents = item.get('contents')
        for item in contents.models
          if item.get('page') is num
            return item
          else if item.get('contents')
            result = search(item)
            return result if result
        return

      return search(@)
