define (require) ->
  _ = require('underscore')
  settings = require('cs!settings')

  shortcodes = settings.shortcodes
  inverseShortcodes = _.invert(shortcodes)

  return new class LinksHelper
    getPath: (page, data) ->
      url = settings.root

      switch page
        when 'contents'
          uuid = "#{data.id}@#{data.version}"
          uuid = inverseShortcodes[uuid] if inverseShortcodes[uuid]
          url += "contents/#{uuid}:#{data.page}"

      return url
