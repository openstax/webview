define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./list-template')
  require('less!./list')

  return class SearchResultsListView extends BaseView
    template: template
    templateHelpers: () ->
      results = @model.get('results').items

      books = _.where(results, {mediaType: "Collection"})
      pages = _.where(results, {mediaType: "Module"})

      return {books: books, pages: pages}
