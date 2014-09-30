define (require) ->
  settings = require('settings')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./list-template')
  require('less!./list')

  AUTHORING = "#{location.protocol}//#{settings.cnxauthoring.host}:#{settings.cnxauthoring.port}"

  # HACK - FIX: Remove after upgrading to Handlebars 2.0
  # Also replace all `{{partial ` helpers with `{{> ` and remove the quotes around partial names
  # Remove the partial.coffee helper
  Handlebars = require('hbs/handlebars')
  Handlebars.registerHelper 'trim', (str) -> str.replace(/\s/g, '_').substring(0, 30)
  itemPartial = require('text!./workspace-item-partial.html')
  Handlebars.registerPartial('modules/workspace/results/list/workspace-item-partial', itemPartial)
  tablePartial = require('text!./workspace-table-partial.html')
  Handlebars.registerPartial('modules/workspace/results/list/workspace-table-partial', tablePartial)
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

      return {
        books: books
        pages: pages
        misc: misc
      }

    events:
      'click td.delete': 'clickDelete'

    clickDelete: (e) ->
      version = $(e.currentTarget).parent().data('id')
      if confirm('Are you sure you want to delete this?')
        @deleteMedia(version)

    deleteMedia: (version) ->
      # maybe make each item its own view and use a delete method on the model?
      # FIX: Remove `.json` from URL
      # FIX: Look into making each list item its own view, remove data-id
      #      from template, and make its model the individual item.
      #       Probably dependent on search-results being made into a collection
      # FIX: Move delete function into node.coffee (@model.destroy())
      $.ajax
        url: "#{AUTHORING}/contents/#{version}.json"
        type: 'DELETE'
        xhrFields:
          withCredentials: true
      .done (response) =>
        @model.fetch()
      .fail (error) ->
        alert("#{error.status}: #{error.statusText}")
