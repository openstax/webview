define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')
  HeaderView = require('cs!modules/header/header')
  FooterView = require('cs!modules/footer/footer')
  FindContentView = require('cs!modules/find-content/find-content')
  BrowseContentView = require('cs!modules/browse-content/browse-content')
  MediaView = require('cs!modules/media/media')
  template = require('hbs!./contents-template')
  require('less!./contents')

  POLLING_REFRESH = 30 * 1000 # milliseconds

  return class ContentsPage extends BaseView
    template: template
    pageTitle: 'Content Library'

    initialize: (options) ->
      super()
      @uuid = options?.uuid
      @page = options?.page

    regions:
      contents: '#contents'

    onRender: () ->
      @parent.regions.footer.show(new FooterView({page: 'contents'}))
      @regions.contents.show(new FindContentView())

      clearTimeout(@_pollingContentTimer)

      if @uuid
        @parent.regions.header.show(new HeaderView({page: 'contents'}))
        view = new MediaView({uuid: @uuid, page: @page})
        @regions.contents.append(view)

        # Start polling for changes
        @listenTo(view.model, 'change:changed-remotely', @displayChangedRemotely)
        @listenTo(view.model, 'change:currentPage.changed-remotely', @displayChangedRemotely)

        pollRemoteUpdates = () =>
          # If the view is detached (the user moved to a different piece of content)
          # then stop polling for updates
          if view.model
            # Check for updates on the content as well as the current Page (if it exists)
            promises = [view.model.fetch()]
            page = view.model.asPage()
            promises.push(page.fetch()) if view.model isnt page

            $.when(promises)
            .then () =>
              @_pollingContentTimer = setTimeout(pollRemoteUpdates, POLLING_REFRESH)

        @_pollingContentTimer = setTimeout(pollRemoteUpdates, POLLING_REFRESH)

      else
        @parent.regions.header.show(new HeaderView({page: 'contents', url: 'contents'}))
        @regions.contents.append(new BrowseContentView())

    displayChangedRemotely: () ->
      alert("This content changed remotely #{@uuid} (or the content in it)")
