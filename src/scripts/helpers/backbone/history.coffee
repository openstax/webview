define (require) ->
  Backbone = require('backbone')

  hashStripper = /[#].*$/
  routeStripper = /^[#\/]|\s+$/g
  trailingSlash = /\/$/

  return Backbone.history = new class History extends Backbone.History
    getFragment: (fragment, forcePushState) ->
      if not fragment
        fragment = @location.pathname + @location.search
        root = @root.replace(trailingSlash, '')
        if not fragment.indexOf(root) then fragment = fragment.slice(root.length)

      return fragment.replace(routeStripper, '')

    navigate: (fragment, options) ->
      if not Backbone.History.started then return false
      if not options or options is true then options = {trigger: !!options}

      url = @root + (fragment = @getFragment(fragment or ''))

      fragment = fragment.replace(hashStripper, '')

      if @fragment is fragment then return
      @fragment = fragment

      if fragment is '' and url isnt '/' then url = url.slice(0, -1)

      if @_hasPushState
        @history[if options.replace then 'replaceState' else 'pushState']({}, document.title, url);
      else if @_wantsHashChange
        @_updateHash(@location, fragment, options.replace)
        if @iframe and (fragment isnt @getFragment(@getHash(@iframe)))
          if not options.replace then @iframe.document.open().close()
          @_updateHash(@iframe.location, fragment, options.replace)
      else
        return this.location.assign(url)

      if options.trigger then return @loadUrl(fragment)
