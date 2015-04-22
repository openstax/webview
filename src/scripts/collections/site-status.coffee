define (require) ->
  Backbone = require('backbone')
  settings = require('settings')
  SiteStatusModel = require('cs!models/site-status')

  archiveport = if settings.cnxarchive.port then ":#{settings.cnxarchive.port}" else ''
  archive = "#{location.protocol}//#{settings.cnxarchive.host}#{archiveport}"

  return new class SiteStatus extends Backbone.Collection
    url: "#{archive}/extras"
    model: SiteStatusModel

    parse: (response) ->
      messages = response.messages
      _.each messages, (message) ->
        message.message = message.message
        message.name = message.name
        message.starts = message.starts
        message.ends = message.ends

        #Check for dismissed message cookie on fetch
        if document.cookie.indexOf(message.name) >= 0
          message.show = false

        #Map priorities to Bootstrap style classes
        if message.priority is 1
          message.priority = 'alert-danger'
        else if message.priority is 2
          message.priority = 'alert-warning'
        else if message.priority is 3
          message.priority = 'alert-success'

      return messages

    initialize: () ->
      @fetch({reset: true})
