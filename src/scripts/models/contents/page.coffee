define (require) ->
  $ = require('jquery')
  Node = require('cs!./node')

  return class Page extends Node
