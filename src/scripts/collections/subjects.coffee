define (require) ->
  Backbone = require('backbone')
  settings = require('cs!settings')

  SERVER = "#{location.protocol}//#{settings.cnxarchive.host}:#{settings.cnxarchive.port}"

  return new class Subjects extends Backbone.Collection
    url: () -> "#{SERVER}/extras"

    initialize: () ->
      @fetch({reset: true})

    parse: (response, options) ->
      return response.subjects
