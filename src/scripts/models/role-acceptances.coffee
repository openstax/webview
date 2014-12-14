define (require) ->
  Backbone = require('backbone')
  settings = require('settings')
  router = require('router')

  AUTHORING = "#{location.protocol}//#{settings.cnxauthoring.host}:#{settings.cnxauthoring.port}"

  return class RoleAcceptance extends Backbone.Model
    url: () -> "#{AUTHORING}/contents/#{@contentId}@draft/acceptance"

    initialize: (options) =>
      @contentId = options.id
      @fetch
        reset: true,
        xhrFields: withCredentials: true
      .fail (response) =>
        router.appView.render('error', {code: response.status})

    save: (key, val, options) ->
      if not key? or typeof key is 'object'
        attrs = key
        options = val
      else
        attrs = {}
        attrs[key] = val

      options = _.extend(
        dataType: 'xml'
        xhrFields:
          withCredentials: true
      , options)

      return super(attrs, options)
