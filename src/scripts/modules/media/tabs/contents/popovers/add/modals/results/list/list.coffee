define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./add-page-list-template')
  require('less!./list')

  return class AddPageSearchResultsListView extends BaseView
    template: template
    templateHelpers: () ->
      results = @model.get('results')?.items or []

      pages = _.where(results, {mediaType: 'application/vnd.org.cnx.module'})

      return {
        authorList: @model.get('results').auxiliary.authors
        pages: pages
      }

    initialize: () ->
      super()
      @listenTo(@model, 'change', @render)
