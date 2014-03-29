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
