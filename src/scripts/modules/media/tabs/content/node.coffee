define (require) ->
  $ = require('jquery')
  router = require('cs!router')
  analytics = require('cs!helpers/handlers/analytics')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./node-template')
  require('less!./node')

  return class TocNodeView extends BaseView
    template: template
    tagName: 'li'
    itemViewContainer: '.subcollection'

    events:
      'click a': 'loadPage'

    initialize: () ->
      super()
      @listenTo(@model, 'change:page change:unit change:title', @render) if @model

    loadPage: (e) ->
      e.preventDefault()
      $a = $(e.currentTarget)

      @model.get('book').setPage($a.data('page'))
      route = $a.attr('href')
      router.navigate(route) # Update browser URL to reflect the new route
      analytics.send() # Send the analytics information for the new route
