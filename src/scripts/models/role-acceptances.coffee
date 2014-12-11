define (require) ->
  Backbone = require('backbone')
  settings = require('settings')
  router = require('router')
  
  AUTHORING = "#{location.protocol}//#{settings.cnxauthoring.host}:#{settings.cnxauthoring.port}"

  return class RoleAcceptance extends Backbone.Model
    id = window.location.pathname.match(/\/[^\/]+$/)
    url: "#{AUTHORING}/contents#{id}@draft/acceptance"
    defaults:
      linkToContent: "#{location.protocol}//#{location.host}/contents#{id}@draft"
      hasAcceptedLicense: false

    initialize: () =>
      @fetch
        reset: true,
        xhrFields: withCredentials: true
      .fail (response) =>
        router.appView.render('error', {code: response.status})

    acceptOrReject: (data) ->
      $.ajax
        type: 'POST'
        data: JSON.stringify(data)
        url: "#{AUTHORING}/contents#{id}@draft/acceptance"
        xhrFields:
          withCredentials: true
      .done () => @model()
