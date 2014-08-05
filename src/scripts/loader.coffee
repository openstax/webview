define (require) ->
  $ = require('jquery')
  Backbone = require('backbone')
  settings = require('settings')
  session = require('cs!session')
  analytics = require('cs!helpers/handlers/analytics')
  router = require('cs!router')
  require('cs!helpers/backbone/history') # Extend Backbone.history to support query strings
  require('less!../styles/main')

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

  init = (options = {}) ->
    # Append /test to the root if the app is in test mode
    if options.test
      root += 'test/'

    external = new RegExp('^((f|ht)tps?:)?\/\/')
    resources = new RegExp('\/(resources|exports)\/')

    # Catch internal application links and let Backbone handle the routing
    $(document).on 'click', 'a[href]:not([data-bypass]):not([href^="#"])', (e) ->
      $this = $(this)
      href = $this.attr('href')

      # Only handle links intended to be processed by Backbone
      if e.isDefaultPrevented() or href.charAt(0) is '#' or /^mailto:.+/.test(href) then return

      e.preventDefault()

      if external.test(href)
        if /^((f|ht)tps?:)?\/\/(\w*\.?)cnx\.org/.test(href)
          # Going to the legacy site
          if document.cookie.indexOf('legacy') >= 0
            location.href = href
          else
            $('#legacy-modal').data('href', href) # Hack to pass href to legacy modal
            $('#legacy-modal').modal()
        else
          window.open(href, '_blank')
      else if resources.test(href)
        window.open(href, '_blank')
      else
        if $this.data('trigger') is false then trigger = false else trigger = true
        router.navigate(href, {trigger: trigger})

    Backbone.history.start
      pushState: true
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
