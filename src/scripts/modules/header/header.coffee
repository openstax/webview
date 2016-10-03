define (require) ->
  session  = require('cs!session')
  settings = require('settings')
  SiteStatusView = require('cs!./site-status/site-status')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./header-template')
  require('less!./header')
  require('bootstrapCollapse')

  return class HeaderView extends BaseView
    template: template
    templateHelpers: () -> {
      legacy: settings.legacy
      cnxSupport: settings.cnxSupport
      page: @page
      results: !!document.getElementById('results')
      url: @url
      username: session.get('id')
      accountProfile: settings.accountProfile
    }

    events:
      'click #skiptocontent a': 'skipTo'
      'click #skiptoresults a': 'skipTo'

    initialize: (options = {}) ->
      super()
      @page = options.page
      @url = @createLink(options.url) if options.url

      @listenTo(session, 'change', @render)

    regions:
      siteStatus: '.site-status'

    onRender: () ->
      @regions.siteStatus.show(new SiteStatusView())

    skipTo: (e) ->
      e.preventDefault()
      hashId = e.target.href.match(/#(.*)/)[1]
      el = document.getElementById(hashId)

      if el
        if !/^(?:a|select|input|button|textarea)$/i.test(el.tagName)
          el.tabIndex = -1

          removeTabIndex = ->
            el.removeAttribute('tabindex')
            el.removeEventListener('blur', removeTabIndex, false)
            el.removeEventListener('focusout', removeTabIndex, false)

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
