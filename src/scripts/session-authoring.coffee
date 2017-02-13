define (require) ->
  ->
    Backbone = require('backbone')
    settings = require('settings')

    authoringport = if settings.cnxauthoring.port then ":#{settings.cnxauthoring.port}" else ''
    SERVER = "#{location.protocol}//#{settings.cnxauthoring.host}#{authoringport}"

    return new class BaseSession extends Backbone.Model
      url: "#{SERVER}/users/profile"

      # Fetches the model, clear it if the server returns an error,
      # and fires a change event any time the session status changes
      update: _.throttle(->
        @fetch(xhrFields: withCredentials: true).fail () => @clear()
      , 5000)
