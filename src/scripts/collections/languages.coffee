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
        lang =
          code: language[0].substring(0, 2)
          name: allLanguages["#{language[0].substring(0, 2)}"].english
        codes.push(lang)
       
      codes.sort (a,b) ->
        return if a.name.toUpperCase() > b.name.toUpperCase() then 1 else -1
      orderedCodes = (lang.code for lang in codes when lang.code)
      for code in orderedCodes
        availableLanguages["#{code}"] = allLanguages["#{code}"]
      return availableLanguages

    initialize: () ->
      @fetch({reset: true})
