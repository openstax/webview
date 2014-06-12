define (require) ->
  $ = require('jquery')
  Node = require('cs!./node')

  return class Page extends Node
    defaults:
      mediaType: 'application/vnd.org.cnx.module'
      content: ''

    toJSON: (options = {}) ->
      results = super(arguments...)

      # Don't send an empty string as an id
      if not results.id
        delete results.id

      return results
