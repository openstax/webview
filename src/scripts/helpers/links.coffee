define (require) ->
  _ = require('underscore')
  Backbone = require('backbone')
  settings = require('settings')
  trim = require('cs!helpers/handlebars/trim')

  shortcodes = settings.shortcodes
  inverseShortcodes = _.invert(shortcodes)

  return new class LinksHelper
    componentRegEx: /^contents\/([^:@/]+)@?([^:/?]*):?([0-9]*)\/?([^?]*)(\?.*)?/

    cleanUrl: trim

    getPath: (page, data) ->
      url = settings.root

      switch page
        when 'contents'
          uuid = data.model.getVersionedId()
          uuid = inverseShortcodes[uuid] if inverseShortcodes[uuid]
          title = data.model.get('title')
          if data.model.asPage?() and data.model.get('currentPage')?
            title = data.model.get('currentPage').get('title')
          url += "contents/#{uuid}"
          url += ":#{data.page}" if data.page
          url += "/#{trim(title)}" if title

      return url

    # Get the URL to view a given content model
    getModelPath: (model) ->
      page = ''
      id = model.getUuid?() or model.id
      version = model.get?('version') or model.version
      title = trim(model.get?('title') or model.title)
      if model.asPage?() and model.get('currentPage')?
        title = trim(model.get?('currentPage').get('title') or model.title)

      if model.isBook?()
        page = ":#{model.getPageNumber()}"

      return "#{settings.root}contents/#{id}#{page}/#{title}"

    getCurrentPathComponents: () ->
      components = Backbone.history.fragment.match(@componentRegEx) or []
      path = components[0]
      if path?.slice(-1) is '/'
        path = path.slice(0, -1)

      return {
        path: path
        uuid: components[1]
        version: components[2]
        page: components[3]
        title: components[4]
        rawquery: components[5] or ''
        query: @serializeQuery(components[5] or '')
      }

    serializeQuery: (query) ->
      queryString = {}

      query.split('?').pop().split('&').forEach (prop) ->
        item = prop.split('=')
        if item.length is 2
          queryString[decodeURIComponent(item.shift())] = decodeURIComponent(item.shift())

      return queryString

    param: (obj) ->
      str = []

      for p of obj
        if obj.hasOwnProperty(p)
          str.push("#{encodeURI(p)}=#{encodeURI(obj[p])}")

      return str.join("&")

    locationOrigin: () ->
      # Polyfill for location.origin since IE doesn't support it
      port = if location.port then ":#{location.port}" else ''
      location.origin = location.origin or "#{location.protocol}//#{location.hostname}#{port}"
