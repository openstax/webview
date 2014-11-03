define (require) ->
  $ = require('jquery')
  Node = require('cs!./node')

  return class Page extends Node
    defaults:
      mediaType: 'application/vnd.org.cnx.module'
      content: '<p>Enter some content here. Format content, and drag and drop elements from the toolbar.</p>'

    toJSON: (options = {}) ->
      results = super(arguments...)

      # Don't send an empty string as an id
      if not results.id
        delete results.id

      return results
