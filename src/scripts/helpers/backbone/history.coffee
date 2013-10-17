define (require) ->
  _ = require('underscore')
  Backbone = require('backbone')

  hashStripper = /[#].*$/
  routeStripper = /^[#\/]|\s+$/g
  trailingSlash = /\/$/

  return _.extend Backbone.history, {
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

      @history[if options.replace then 'replaceState' else 'pushState']({}, document.title, url)

      if options.trigger then return @loadUrl(fragment)
  }
