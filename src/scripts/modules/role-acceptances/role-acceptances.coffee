define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  settings = require('settings')
  BaseView = require('cs!helpers/backbone/views/base')
  RoleAcceptances = require('cs!models/role-acceptances')
  template = require('hbs!./role-acceptances-template')
  require('less!./role-acceptances')

  AUTHORING = "#{location.protocol}//#{settings.cnxauthoring.host}:#{settings.cnxauthoring.port}"

  return  class RoleAcceptanceView extends BaseView
    template: template
    pageTitle: 'Role Acceptance'

    templateHelpers:
      licenseRequired: () -> !!_.findWhere(@model.get('roles'), {hasAccepted: true})

    events:
      'click .submit': 'onSubmit'
      'click .accept': 'acceptRole'
      'click .reject': 'rejectRole'

    initialize: () ->
      @model = new RoleAcceptances()

      @listenTo(@model, 'reset', @render)
      @listenTo(@model, 'change:hasAcceptedLicense change:hasAccepted change:roles', @render)

    acceptRole: (e) ->
      role = @model.get('roles')[$(e.currentTarget).data('role')]
      if role.hasAccepted is true then role.hasAccepted = null else role.hasAccepted = true
      @render()

    rejectRole: (e) ->
      role = @model.get('roles')[$(e.currentTarget).data('role')]
      if role.hasAccepted is false then role.hasAccepted = null else role.hasAccepted = false
      @render()

    onSubmit: () ->
      roleRequests= []
      @acceptLicense(@model)
      rolesList = @model?.get('roles')
      data = {'license': @model.get('hasAcceptedLicense'), 'roles': roleRequests}
      isAccepted = []

      _.each rolesList, (role) ->
        if role.hasAccepted is 'true' or role.hasAccepted is true
          isAccepted.push(role)
        roles = {'role': role.role, 'hasAccepted': role.hasAccepted}
        roleRequests.push(roles)

      if isAccepted.length > 0  and model.get('hasAcceptedLicense') is false
        alert 'You must accept the license.'
      else
        @model.acceptOrReject(data)
