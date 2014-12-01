define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./list-template')
  DeleteModal = require('cs!../../popovers/delete/modals/delete')
  require('less!./list') 

  # HACK - FIX: Remove after upgrading to Handlebars 2.0
  # Also replace all `{{partial ` helpers with `{{> ` and remove the quotes around partial names
  # Remove the partial.coffee helper
  Handlebars = require('hbs/handlebars')
  Handlebars.registerHelper 'trim', (str) -> str.replace(/\s/g, '_').substring(0, 30)
  Handlebars.registerHelper 'noVersion', (id) -> return id.split('@')[0]
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


    initialize: () ->
      @deleteModal = new DeleteModal({model: @model})


    onRender: () ->
      @parent.regions.self.appendOnce
        view: @deleteModal
        as: 'div id="delete" class="modal fade"'


    events:
      'click .delete': 'clickDelete'


    clickDelete: (e) ->
      @setVersionAndTitle(e)
      @deleteModal.show()


    setVersionAndTitle: (e) ->
      version = $(e.currentTarget).parent().data('id')
      title = $(e.currentTarget).parent().find('td.title').text()
      @model.set('version', version)
      @model.set('title', title)
