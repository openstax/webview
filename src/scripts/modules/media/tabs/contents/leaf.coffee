define (require) ->
  $ = require('jquery')
  linksHelper = require('cs!helpers/links')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./leaf-template')
  require('less!./leaf')

  return class TocNodeView extends BaseView
    template: template
    templateHelpers:
      url: () ->
        book = @model.get('book').toJSON()
        return linksHelper.getPath('contents', {id: book.id, version: book.version})

    tagName: 'li'
    itemViewContainer: '.subcollection'

    events:
      'click a': 'changePage'

    initialize: () ->
      super()
      @listenTo(@model, 'change:active change:page', @render)

    changePage: (e) ->
      @model.get('book').setPage($(e.currentTarget).data('page'))
