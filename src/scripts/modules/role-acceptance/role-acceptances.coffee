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
      @listenTo(@collection, 'change:hasAcceptedLicense', @render)
      @listenTo(@collection, 'change:checked', @render)


    onRender: () ->
      #@setColor()


    setColor: () ->
      isPending = $('*[data-has-accepted=""]')
      isRejected = $('*[data-has-accepted="false"]')
      isAccepted = $('*[data-has-accepted="true"]')
      isPending.addClass('isPending')
      isRejected.addClass('isRejected')
      isAccepted.addClass('isAccepted')


    roles: (e) ->
      model = @collection.at(0)
      if $(e.currentTarget).is(':checked')
        model.set('checked',true)
      else
        model.set('checked',false)


    acceptLicense: (e) ->
      model = @collection.at(0)
      if $(e.currentTarget).is(':checked')
        model.set('hasAcceptedLicense', true)
      else
        model.set('hasAcceptedLicense', false)


    acceptOrRejectRoles: () ->
      model = @collection.at(0)
      rolesCheckbox = $('.rolesCheckbox')
      roleRequests= []
      data = {"license": model.get('hasAcceptedLicense'), "roles": roleRequests}

      _.each rolesCheckbox, (roles) ->
        requestedRole = $(roles).attr('data-requested-role')
        if rolesCheckbox.is(':checked') and model.get('hasAcceptedLicense')
          model.set('hasAccepted', true)
        else if rolesCheckbox.is(':checked') and !!model.get('hasAcceptedLicense')
          model.set('hasAccepted', false)
        else
          model.set('hasAccepted', false)

        roles = {"role": requestedRole, "hasAccepted": model.get('hasAccepted')}
        roleRequests.push(roles)

       @collection.acceptOrReject(data)
