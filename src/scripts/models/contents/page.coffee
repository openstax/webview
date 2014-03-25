define (require) ->
  $ = require('jquery')
  Node = require('cs!./node')

  return class Page extends Node
    parse: (response, options) ->
      response = super(arguments...)

      # FIX: cnx-authoring should not return a null value for content
      response.content = response.content or ''

      # jQuery can not build a jQuery object with <head> or <body> tags,
      # and will instead move all elements in them up one level.
      # Use a regex to extract everything in the body and put it into a div instead.
      $body = $('<div>' + response.content.replace(/^[\s\S]*<body.*?>|<\/body>[\s\S]*$/g, '') + '</div>')
      $body.children('.title').eq(0).remove()
      $body.children('.abstract').eq(0).remove()

      response.content = $body.html()

      return response
