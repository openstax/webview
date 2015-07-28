define (require) ->
  session  = require('cs!session')
  settings = require('settings')
  SiteStatusView = require('cs!./site-status/site-status')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./header-template')
  require('less!./header')
  require('bootstrapCollapse')
  require('zendesk')

  return class HeaderView extends BaseView
    template: template
    templateHelpers: () -> {
      legacy: settings.legacy
      page: @page
      url: @url
      username: session.get('id')
      accountProfile: settings.accountProfile
    }

    events:
      'click #skiptocontent a': 'skipToContent'

    initialize: (options = {}) ->
      super()
      @page = options.page
      @url = @createLink(options.url) if options.url

      @listenTo(session, 'change', @render)

    regions:
      siteStatus: '.site-status'

    onRender: () ->
      @regions.siteStatus.show(new SiteStatusView())

    skipToContent: (e) ->
      el = document.getElementById('main')

      if el
        if !/^(?:a|select|input|button|textarea)$/i.test(el.tagName)
          el.tabIndex = -1

          removeTabIndex = () ->
            this.removeAttribute('tabindex')
            this.removeEventListener('blur', removeTabIndex, false)
            this.removeEventListener('focusout', removeTabIndex, false)

          el.addEventListener('blur', removeTabIndex, false)
          el.addEventListener('focusout', removeTabIndex, false)

        el.focus()

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
