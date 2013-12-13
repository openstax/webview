define (require) ->
  $ = require('jquery')
  router = require('cs!router')
  analytics = require('cs!helpers/handlers/analytics')
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
      'click a': 'loadPage'

    initialize: () ->
      super()
      @listenTo(@model, 'change:active change:page', @render)

    loadPage: (e) ->
      e.preventDefault()
      $a = $(e.currentTarget)

      @model.get('book').setPage($a.data('page'))
      route = $a.attr('href')
      router.navigate(route) # Update browser URL to reflect the new route
      analytics.send() # Send the analytics information for the new route
