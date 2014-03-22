define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./list-template')
  require('less!./list')

  return class SearchResultsListView extends BaseView
    template: template
    templateHelpers: () ->
      results = @model.get('results')?.items or []

      books = _.where(results, {mediaType: 'Collection'})
      pages = _.where(results, {mediaType: 'Module'})
      misc = _.filter(results, (result) -> result.mediaType isnt 'Collection' and result.mediaType isnt 'Module')

      return {books: books, pages: pages, misc: misc}

    initialize: () ->
      super()
      @listenTo(@model, 'change', @render)
