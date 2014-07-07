define (require) ->
  Handlebars = require('hbs/handlebars')
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

      # Determine the url to use for pagination links
      url = window.location.pathname + '?'
      url += _.filter window.location.search.slice(1).split('&'), (query) ->
        return query.substr(0,5) isnt 'page='
      .join('&') + '&page='

      pagination =
        pageCount: Math.ceil(@model.get('results').total / @model.get('query').per_page)
        page: @model.get('query').page
        url: url

      return {books: books, pages: pages, misc: misc, pagination: pagination}

    initialize: () ->
      super()
      @listenTo(@model, 'change', @render)
