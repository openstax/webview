define (require) ->
  linksHelper = require('cs!helpers/links')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./list-template')
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
  itemPartial = require('text!./item-partial.html')
  Handlebars.registerPartial('modules/search/results/list/item-partial', itemPartial)
  tablePartial = require('text!./table-partial.html')
  Handlebars.registerPartial('modules/search/results/list/table-partial', tablePartial)
  Handlebars.registerHelper 'titleForUrl', (title) -> title.replace(/\ /g,'_').substring(0,30)
  # /HACK

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

