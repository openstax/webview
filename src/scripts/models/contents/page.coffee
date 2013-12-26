define (require) ->
  $ = require('jquery')
  toc = require('cs!collections/toc')
  Node = require('cs!./node')
  require('backbone-associations')

  return class Page extends Node
    defaults:
      authors: []

    constructor: () ->
      super(arguments...)
      toc.add(@)

    parse: (response, options) ->
      resonse = super(arguments...)

      # jQuery can not build a jQuery object with <head> or <body> tags,
      # and will instead move all elements in them up one level.
      # Use a regex to extract everything in the body and put it into a div instead.
      $body = $('<div>' + response.content.replace(/^[\s\S]*<body.*?>|<\/body>[\s\S]*$/g, '') + '</div>')
      $body.children('[data-type="title"]').eq(0).remove()
      $body.children('[data-type="abstract"]').eq(0).remove()

      # Wrap title and content elements in header and section elements, respectively
      $body.find('[data-type="example"], [data-type="exercise"], [data-type="note"]').each (index, el) ->
        $el = $(el)
        $contents = $el.contents().filter (i, node) ->
          return !$(node).hasClass('title')
        $contents.wrapAll('<section>')
        $title = $el.children('[data-type="title"]')
        $title.wrap('<header>')
        # Add an attribute for the parents' `data-label`
        # since CSS does not support `parent(attr(data-label))`.
        # When the title exists, this attribute is added before it
        $title.attr('data-label-parent', $el.attr('data-label'))
        # Add a class for styling since CSS does not support `:has(> .title)`
        # NOTE: `.toggleClass()` explicitly requires a `false` (not falsy) 2nd argument
        $el.toggleClass('ui-has-child-title', $title.length > 0)


      # Wrap solutions in a div so "Show/Hide Solutions" work
      $body.find('[data-type="solution"]')
      .wrapInner('<section class="ui-body">')
      .prepend('''
        <div class="ui-toggle-wrapper">
          <button class="btn-link ui-toggle" title="Show/Hide Solution"></button>
        </div>''')

      response.content = $body.html()

      return response
