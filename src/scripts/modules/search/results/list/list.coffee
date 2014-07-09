define (require) ->
  linksHelper = require('cs!helpers/links')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./list-template')
  require('less!./list')

  return class SearchResultsListView extends BaseView
    template: template
    templateHelpers: () ->
      results = @model.get('results').items

      books = _.where(results, {mediaType: 'Collection'})
      pages = _.where(results, {mediaType: 'Module'})
      misc = _.filter(results, (result) -> result.mediaType isnt 'Collection' and result.mediaType isnt 'Module')

      queryString = linksHelper.serializeQuery(location.search)
      delete queryString.page

      pagination =
        pageCount: Math.ceil(@model.get('results').total / @model.get('query').per_page)
        page: @model.get('query').page
        url: "#{location.pathname}?#{linksHelper.param(queryString)}&page="

      return {books: books, pages: pages, misc: misc, pagination: pagination}

    initialize: () ->
      super()
      @listenTo(@model, 'change', @render)
