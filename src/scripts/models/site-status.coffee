define (require) ->
  _ = require('underscore')
  $ = require('jquery')
  Backbone = require('backbone')
  settings = require('settings')

  archiveport = if settings.cnxarchive.port then ":#{settings.cnxarchive.port}" else ''
  archive = "#{location.protocol}//#{settings.cnxarchive.host}#{archiveport}"

  return new class SiteStatus extends Backbone.Model
    #urlRoot: "#{archive}/extras"
    urlRoot: 'data/messages.json'

    initialize: () ->
      @fetch()
      @set('dateTime', @dateTime())

    parse: (response) ->
      _.each response.messages, (message) ->
        if message.priority is '1'
          message.priority = 'alert-danger'
        else if message.priority is '2'
          message.priority = 'alert-warning'
        else if message.priority is '3'
          message.priority = 'alert-success'

      return response

    dateTime: () ->
      date = new Date()
      date.toISOString()
