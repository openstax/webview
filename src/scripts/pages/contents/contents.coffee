define (require) ->
  $ = require('jquery')
  linksHelper = require('cs!helpers/links')
  BaseView = require('cs!helpers/backbone/views/base')
  MediaView = require('cs!modules/media/media')
  router = require('cs!router')
  template = require('hbs!./contents-template')
  require('less!./contents')

  return class ContentsPage extends BaseView
    template: template
    pageTitle: 'content-library-pageTitle'
    canonical: () -> null if not @uuid
    summary: 'content-library-summary'
    description: 'content-library-description'

    initialize: (options = {}) ->
      super()
      @uuid = options.uuid
      @version = options.version
      @page = options.page
      @title = options.title

      queryString = linksHelper.serializeQuery(location.search)
      @minimal = false
      if queryString.minimal
        @minimal = true

    regions:
      sidebar: '#sidebar'
      contents: '#contents'

    onRender: () ->
      if @uuid
        view = new MediaView(
          uuid: @uuid
          version: @version
          page: @page
          title: @title
          minimal: @minimal
          )
        @regions.contents.append(view)
      else
        router.navigate('/browse', {trigger: true})

    displayChangedRemotely: () ->
      # Regions do not support a `.$el` unless `.show(view)` has been called so select the alert
      # with jQuery and unhide it.
      @$el.find('.changed-remotely-alert').removeClass('hidden')

      # Add a class to this div to hide the floating toolbar because
      # the refresh alert is now shown and they would otherwise overlap
      # TODO: This should probably be handled by editable
      @regions.contents.$el.addClass('changed-remotely')
