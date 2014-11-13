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
    templateHelpers: (e) ->
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
      'click .ok' : 'deleteMedia'

    clickDelete: (e) ->
      version = $(e.currentTarget).parent().data('id')
      title = $(e.currentTarget).parent().find('td.title').text()
      $('#delete').modal()
      $('input[type="hidden"]').val(version)
      $('.modal-body').html("<p>Are you sure you want to delete #{title}?</p>")

    deleteMedia: () ->
      # maybe make each item its own view and use a delete method on the model?
      # FIX: Remove `.json` from URL
      # FIX: Look into making each list item its own view, remove data-id
      #      from template, and make its model the individual item.
      #       Probably dependent on search-results being made into a collection
      # FIX: Move delete function into node.coffee (@model.destroy())
      version = $('#version').val()
      $.ajax
        url: "#{AUTHORING}/contents/#{version}.json"
        type: 'DELETE'
        xhrFields:
          withCredentials: true
      .done (response) =>
        @model.fetch()
      .fail (error) ->
        alert("#{error.status}: #{error.statusText}")
