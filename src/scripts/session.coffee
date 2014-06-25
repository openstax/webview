define (require) ->
  Backbone = require('backbone')
  settings = require('settings')

  SERVER = "#{location.protocol}//#{settings.cnxauthoring.host}:#{settings.cnxauthoring.port}"
  INTERVAL = 1000 * 60 # 1 minute
  MINIMUM_INTERVAL = 1000 * 5 # 5 seconds

  _timer = null
  _lastUpdate = null

  return new class Session extends Backbone.Model
    url: "#{SERVER}/users/profile"

    startChecking: () ->
      #@update() # Initially check immediately
      #_timer = setInterval(() =>
      #  @update()
      #, INTERVAL)

    stopChecking: () ->
      #clearInterval(_timer)
      #_timer = null

    # Fetches the model, clear it if the server returns an error,
    # and fires a change event any time the session status changes
    update: () ->
      #currentTime = (new Date()).getTime()

      # Don't update faster than every 5 seconds
      #if not _lastUpdate or currentTime - _lastUpdate > MINIMUM_INTERVAL
      #  _lastUpdate = currentTime
      #  @fetch(xhrFields: withCredentials: true).fail () => @clear()
