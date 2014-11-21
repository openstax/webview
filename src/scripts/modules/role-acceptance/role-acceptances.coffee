define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./role-acceptance-template')
  RoleAcceptances = require('cs!collections/role-acceptances')
  $ = require('jquery')
  settings = require('settings')
  _ = require('underscore')
  require('less!./role-acceptance')

  AUTHORING = "#{location.protocol}//#{settings.cnxauthoring.host}:#{settings.cnxauthoring.port}"

  return  class RoleAcceptanceView extends BaseView
    template: template
    collection: RoleAcceptances

    events:
      'click .submit': 'acceptOrRejectRoles'
      'change .licenseCheckbox' : 'acceptLicense'

    initialize: () ->
      @listenTo(@collection, 'reset', @render)
      @listenTo(@collection, 'change:hasAccepted change:hasAcceptedLicense', @render)

    onRender: () ->
      isPending = $('*[data-has-accepted=""]')
      hasRejected = $('*[data-has-accepted="false"]')
      isPending.addClass('pending')
      hasRejected.addClass('hasRejected')


    acceptLicense: (e) ->
      model = @collection.at(0)
      if $(e.currentTarget).is(':checked')
        model.set('hasAcceptedLicense', true)
      else
        model.set('hasAcceptedLicense', false)


    acceptOrRejectRoles: () ->
      model = @collection.at(0)
      rolesCheckbox = $('.rolesCheckbox')
      licenseCheckbox = $('.licenseCheckbox')
      roleRequests= []
      data = {"license": model.get('hasAcceptedLicense'), "roles": roleRequests}

      rolesCheckbox.each () ->
        requestedRole = rolesCheckbox.attr('data-requested-role')
        hasAccepted = false
        if rolesCheckbox.is(':checked') and licenseCheckbox.is(':checked')
          model.set('hasAccepted', true)
        else
          model.set('hasAccepted', false)
        roles = {"role": requestedRole, "hasAccepted": model.get('hasAccepted')}
        roleRequests.push(roles)

      @collection.acceptOrReject(data)
