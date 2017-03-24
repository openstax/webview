define (require) ->
  $ = require('jquery')
  Backbone = require('backbone')
  settings = require('settings')
  AvailableLanguage = require('cs!models/available-language')

  archiveport = if settings.cnxarchive.port then ":#{settings.cnxarchive.port}" else ''
  archive = "#{location.protocol}//#{settings.cnxarchive.host}#{archiveport}"

  return new class AvailableLanguages extends Backbone.Collection
    url: "#{archive}/extras"
    model: AvailableLanguage
    comparator: 'english'

    parse: (response) ->
      languages = response.languages_and_count
      allLanguages = settings.languages
      availableLanguages = []
      _.each languages, (language) ->
        if language[0]?
          id = language[0].substring(0, 2)
          availableLanguages.push({
            id: id
            native: allLanguages[id]
          })
      return availableLanguages

    initialize: () ->
      @fetch({reset: true})
