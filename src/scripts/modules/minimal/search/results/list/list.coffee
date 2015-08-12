define (require) ->
  linksHelper = require('cs!helpers/links')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./list-template')
  require('less!./list')

  return class SearchResultsListView extends BaseView
    template: template

    templateHelpers: () ->
      results = @model.get('results').items
      books = _.where(results, {mediaType: 'application/vnd.org.cnx.collection'})
      pages = _.where(results, {mediaType: 'application/vnd.org.cnx.module'})
      misc = _.filter results, (result) ->
        result.mediaType isnt 'application/vnd.org.cnx.collection' and
        result.mediaType isnt 'application/vnd.org.cnx.module'

      queryString = linksHelper.serializeQuery(location.search)
      delete queryString.page

      pagination =
        pageCount: Math.ceil(@model.get('results').total / @model.get('query').per_page)
        page: @model.get('query').page
        url: "#{location.pathname}?#{linksHelper.param(queryString)}&page="

      return {
        authorList: @model.get('results').auxiliary.authors
        books: books
        pages: pages
        misc: misc
        pagination: pagination
      }

    initialize: () ->
      super()
      @listenTo(@model, 'change', @render)

