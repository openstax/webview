define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./add-page-list-template')
  require('less!./list')

  return class AddPageSearchResultsListView extends BaseView
    template: template
    templateHelpers: () ->
      results = @model.get('results')?.items or []

      books = _.where(results, {mediaType: 'application/vnd.org.cnx.collection'})
      pages = _.where(results, {mediaType: 'application/vnd.org.cnx.module'})
      misc = _.filter results, (result) ->
        result.mediaType isnt 'application/vnd.org.cnx.collection' and
        result.mediaType isnt 'application/vnd.org.cnx.module'

      return {books: books, pages: pages, misc: misc}

    initialize: () ->
      super()
      @listenTo(@model, 'change', @render)
