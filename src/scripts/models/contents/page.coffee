define (require) ->
  $ = require('jquery')
  Node = require('cs!./node')

  return class Page extends Node
    defaults:
      mediaType: 'application/vnd.org.cnx.module'
      content: ''
