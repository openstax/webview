define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./add-page-list-template')
  require('less!./list')

  # HACK - FIX: Remove after upgrading to Handlebars 2.0
  # Also replace all `{{partial ` helpers with `{{> ` and remove the quotes around partial names
  # Remove the partial.coffee helper
  Handlebars = require('hbs/handlebars')
  Handlebars.registerHelper 'author', (list, index, property) ->
    return new Handlebars.SafeString(list[index][property])
  Handlebars.registerHelper 'include', (html) ->
    if html is null or html is undefined then return
    return new Handlebars.SafeString(html)
  itemPartial = require('text!./add-page-item-partial.html')
  Handlebars.registerPartial('modules/media/tabs/contents/popovers/add/modals/results/list/add-page-item-partial',
                             itemPartial)
  tablePartial = require('text!./add-page-table-partial.html')
  Handlebars.registerPartial('modules/media/tabs/contents/popovers/add/modals/results/list/add-page-table-partial',
                             tablePartial)
  # /HACK

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
