define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./book-search-results-template')
  router = require('cs!router')
  require('less!./book-search-results')

  return class BookSearchResultsView extends BaseView
    template: template

    events:
      'click a': 'changePage'

    initialize: (options) ->
      super()
      @collection = new Backbone.Collection()

    setBook: (@book) ->

    changePage: (e) ->
      # Don't intercept cmd/ctrl-clicks intended to open a link in a new tab
      return if e.metaKey or e.which isnt 1
      e.preventDefault()
      e.stopPropagation()
      $link = $(e.currentTarget)
      pageId = $link.data('page')
      @book.setPage(pageId)

    setResults: (searchResults) ->
      @collection.reset()
      console.debug("Results:", searchResults)
      _.each(searchResults.items, (item) =>
        pageId = item.id.replace(/\@.*/, '')
        @collection.add({
          snippetText: item.headline.replace('<q-match>', '<span class="match">').replace('</q-match>', '</span>')
          pageUrl: "/contents/#{searchResults.query.id}:#{pageId}"
          pageId: pageId
          }))
      @render()
