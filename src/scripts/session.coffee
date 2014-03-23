define (require) ->
  Backbone = require('backbone')
  settings = require('settings')

  SERVER = "#{location.protocol}//#{settings.cnxarchive.host}:#{settings.cnxauthoring.port}"

  _authenticated = false

  return new class Session extends Backbone.Model
    url: "#{SERVER}/users/profile"

    login: () ->
      @fetch
        success: (model, response, options) =>
          # Logged in
          @set('user', response)

          _authenticated = true
          @trigger('login')

        error: (model, response, options) ->
          console.log 'Failed to load session.'

    logout: () ->
      @reset()
      @clear()
      @trigger('logout')

    reset: () ->
      _authenticated = false
      @set('user', null)

    authenticated: () ->
      return _authenticated

    user: () ->
      return @get('user')
