define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./list-template')
  DeleteModal = require('cs!../../popovers/delete/modals/delete')
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
