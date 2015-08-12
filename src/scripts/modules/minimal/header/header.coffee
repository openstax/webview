define (require) ->
  session  = require('cs!session')
  settings = require('settings')
  SiteStatusView = require('cs!../../header/site-status/site-status')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./header-template')
  require('less!../../header/header')
  require('bootstrapCollapse')
  # require('zendesk') # remove for minimal (its unused here)

  return class HeaderView extends BaseView
    template: template
    templateHelpers: () -> {
      legacy: settings.legacy
      page: @page
      url: @url
      username: session.get('id')
      accountProfile: settings.accountProfile
    }

    initialize: (options = {}) ->
      super()
      @page = options.page
      @url = @createLink(options.url) if options.url

      @listenTo(session, 'change', @render)

    regions:
      siteStatus: '.site-status'

    onRender: () ->
      @regions.siteStatus.show(new SiteStatusView())

    setLegacyLink: (url) ->
      if url
        @url = @createLink(url)
      else
        @url = null
      @render()

    removeLegacyLink: (url) ->
      @setLegacyLink()

    createLink: (url) ->
      link = "//#{settings.legacy}/#{url}"
      if link.indexOf('?') >= 0
        link += '&'
      else
        link += '?'

      return "#{link}legacy=true"
