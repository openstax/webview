define (require) ->
  _ = require('underscore')
  settings = require('settings')

  shortcodes = settings.shortcodes
  inverseShortcodes = _.invert(shortcodes)

  return new class LinksHelper
    getPath: (page, data) ->
      url = settings.root

      switch page
        when 'contents'
          uuid = data.model.getVersionedId()
          uuid = inverseShortcodes[uuid] if inverseShortcodes[uuid]
          url += "contents/#{uuid}"
          url += ":#{data.page}" if data.page

      return url

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
