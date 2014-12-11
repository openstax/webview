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
      licenseRequired: () -> @licenseRequired()

    events:
      'submit form': 'onSubmit'
      'click .accept': 'acceptRole'
      'click .reject': 'rejectRole'

    initialize: () ->
      @model = new RoleAcceptances()
      @listenTo(@model, 'change:roles', @render)

    acceptRole: (e) ->
      role = @model.get('roles')[$(e.currentTarget).data('role')]
      if role.hasAccepted is true then role.hasAccepted = null else role.hasAccepted = true
      @render()

    rejectRole: (e) ->
      role = @model.get('roles')[$(e.currentTarget).data('role')]
      if role.hasAccepted is false then role.hasAccepted = null else role.hasAccepted = false
      @render()

    onSubmit: (e) ->
      e.preventDefault()

      licenseAccepted = @$el.find('.license-accept').is(':checked')
      @model.set('license', licenseAccepted)

      if licenseAccepted or not @licenseRequired()
        @model.save()
      else
        alert('You must accept the license')

    licenseRequired: () -> !!_.findWhere(@model.get('roles'), {hasAccepted: true})
