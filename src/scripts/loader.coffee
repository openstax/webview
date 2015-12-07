define (require) ->
  # This needs to load first--at least for now--to ensure that styles in main is loaded before
  # component specific styles.  This affects the order of the styles in the dist version.
  require('less!../styles/main')
  $ = require('jquery')
  Backbone = require('backbone')
  settings = require('settings')
  session = require('cs!session')
  analytics = require('cs!helpers/handlers/analytics')
  router = require('cs!router')
  require('cs!helpers/backbone/history') # Extend Backbone.history to support query strings

  RegExp.escape = (str) -> str.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&')

  # The root URI prefixed on all non-external AJAX and Backbone URIs
  root = settings.root

  # Patch `Backbone.sync` so unauthorized responses are redirected to `/login`
  Backbone_sync = Backbone.sync
  Backbone.sync = (method, model, options) ->
    promise = Backbone_sync.call(@, method, model, options)

    # Do not redirect when trying to determine the login state
    # But redirect otherwise
    if model isnt session
      promise.fail (jqXHR) ->
        switch jqXHR.status
          when 401
            window.location.href = '/login'

    return promise

  # Trick to download a file with JavaScript
  downloadUrl = (url) ->
    hiddenIFrameId = 'hiddenDownloader'
    iframe = document.getElementById(hiddenIFrameId)
    if iframe is null
      iframe = document.createElement('iframe')
      iframe.id = hiddenIFrameId
      iframe.style.display = 'none'
      document.body.appendChild(iframe)

    iframe.src = url

  init = (options = {}) ->
    legacy = new RegExp("^((f|ht)tps?:)?\/\/#{RegExp.escape(settings.legacy)}")
    download = /^\/(exports)\//
    external = /^((f|ht)tps?:)?\/\//
    resources = /\/(resources|exports)\//
    mailto = /^mailto:(.+)/
    exports = /exports\/([^\/:]+).(pdf|epub|zip)/

    # Catch internal application links and let Backbone handle the routing
    $(document).on 'click', 'a[href]:not([data-bypass]):not([href^="#"])', (e) ->
      # Don't intercept cmd/ctrl-clicks intended to open a link in a new tab
      return if e.metaKey or e.which isnt 1

      $this = $(this)
      href = $this.attr('href')

      # Only handle links intended to be processed by Backbone
      if e.isDefaultPrevented() or href.charAt(0) is '#' or mailto.test(href) then return

      e.preventDefault()

      if external.test(href)
        if legacy.test(href)
          location.href = href
        else
          window.open(href, '_blank')
      else if download.test(href)
        if document.cookie.indexOf('donation') is -1
          content = href.match(exports)
          router.navigate("/donate/download/#{content[1]}/#{content[2]}", {trigger: true})
        else
          downloadUrl(href)

      else if resources.test(href)
        window.open(href, '_blank')
      else
        if $this.data('trigger') is false then trigger = false else trigger = true
        router.navigate(href, {trigger: trigger})

    Backbone.history.start
      pushState: true
      hashChange: false
      root: root

    # Force Backbone to register the full path including the query in its history
    if location.search
      router.navigate(Backbone.history.fragment, {replace: true})

    analytics.send() # Track analytics for the initial page

    session.startChecking() # Begin tracking session status

    # Prefix all non-external AJAX requests with the root URI
    $.ajaxPrefilter (options, originalOptions, jqXHR) ->
      if not external.test(options.url)
        options.url = root + options.url

      return

  return {init: init}
