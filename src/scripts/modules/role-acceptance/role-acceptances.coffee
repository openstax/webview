define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./role-acceptance-template')
  RoleAcceptances = require('cs!collections/role-acceptances')
  $ = require('jquery')
  settings = require('settings')
  require('less!./role-acceptance')

  AUTHORING = "#{location.protocol}//#{settings.cnxauthoring.host}:#{settings.cnxauthoring.port}"

  return  class RoleAcceptanceView extends BaseView
    template: template
    collection: RoleAcceptances

    events:
      'click .accept, .reject': 'acceptOrRejectRoleAndLicense'

    initialize: () ->
      @listenTo(@collection, 'reset', @render)
      @listenTo(@collection, 'change:hasAccepted change:hasAcceptedLicense', @render)

    onRender: () ->
      isPending = $('*[data-has-accepted=""]')
      hasRejected = $('*[data-has-accepted="false"]')
      isPending.addClass('pending')
      hasRejected.addClass('hasRejected')

    acceptOrRejectRoleAndLicense: (e) ->
      e.preventDefault()
      target = $(e.currentTarget)
      checked = target.closest('tr').find('input[type="checkbox"]')
      role = checked.attr('data-role-acceptance')

      model = @collection.at(0)
      model.set('hasAccepted', false)
      model.set('hasAcceptedLicense', false)

      if target.hasClass('accept')
        model.set('hasAccepted',true)
        model.set('hasAcceptedLicense',true)

      hasAccepted = model.get('hasAccepted')
      license = model.get('hasAcceptedLicense')

      if checked.is(':checked')
        data = {"license": license, "roles": [{"role": role, "hasAccepted": hasAccepted}]}
        json = JSON.stringify(data)
        id = window.location.pathname.match(/\/[^\/]+$/)

        $.ajax
          type: 'POST'
          data: json
          url: "#{AUTHORING}/contents#{id}@draft/acceptance"
          dataType:'json'
          xhrFields:
            withCredentials: true
        .done () ->
          console.log 'done'
