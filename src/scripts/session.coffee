define [
  'backbone'
], (Backbone) ->

  _authenticated = false

  return new class Session extends Backbone.Model
    url: '/me'

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
