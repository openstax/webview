define (require) ->
  Backbone = require('backbone')
  settings = require('settings')

  archiveport = if settings.cnxarchive.port then ":#{settings.cnxarchive.port}" else ''
  archive = "#{location.protocol}//#{settings.cnxarchive.host}#{archiveport}"

  return new class Language extends Backbone.Collection
    url: "#{archive}/extras"

    parse: (response) ->
      languages = response.languages_and_count
      allLanguages = settings.languages
      availableLanguages = {}
      codes = []
      _.each languages, (language) ->
        code = language[0].substring(0, 2)
        lang =
          code: code
          name: allLanguages[code].english
        codes.push(lang)

      # Sort the languages in alphabetical order
      codes.sort (a,b) ->
        return if a.name > b.name then 1 else -1

      for lang in codes
        availableLanguages[lang.code] = allLanguages[lang.code]
      return availableLanguages

    initialize: () ->
      @fetch({reset: true})
