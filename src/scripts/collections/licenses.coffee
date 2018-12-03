define (require) ->
  Backbone = require('backbone')
  settings = require('json!settings.json')

  archiveport = if settings.cnxarchive.port then ":#{settings.cnxarchive.port}" else ''
  archive = "#{location.protocol}//#{settings.cnxarchive.host}#{archiveport}"

  return new class License extends Backbone.Collection
    url: "#{archive}/extras/licenses"

    parse: (response) ->
      licenses = response.licenses
      _.each licenses, (license) ->
        license.name = license.name
        license.code = license.code
        license.url = license.url
        license.version = license.version
      return licenses

    initialize: () ->
      @fetch({reset: true})
