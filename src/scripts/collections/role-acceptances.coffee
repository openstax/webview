define (require) ->
  Backbone = require('backbone')
  RoleAcceptances = require('cs!models/role-acceptances')
  settings = require('settings')

  AUTHORING = "#{location.protocol}//#{settings.cnxauthoring.host}:#{settings.cnxauthoring.port}"

  return new class RoleAcceptanceCollections extends Backbone.Collection
    id = window.location.pathname.match(/\/[^\/]+$/)
    url: "#{AUTHORING}/contents#{id}@draft/acceptance"
    model: RoleAcceptances

    initialize: () ->
      @fetch({reset: true})

    acceptOrReject: (data) ->
      $.ajax
        type: 'POST'
        data: JSON.stringify(data)
        url: "#{AUTHORING}/contents#{id}@draft/acceptance"
      .done () =>
        @fetch({reset: true})
