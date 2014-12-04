define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./role-acceptance-template')
  RoleAcceptances = require('cs!collections/role-acceptances')
  settings = require('settings')
  $ = require('jquery')
  _ = require('underscore')
  require('less!./role-acceptance')

  AUTHORING = "#{location.protocol}//#{settings.cnxauthoring.host}:#{settings.cnxauthoring.port}"

  return  class RoleAcceptanceView extends BaseView
    template: template
    collection: RoleAcceptances
    pageTitle: 'Role Acceptance'


    templateHelpers: () ->
      accepted = @accepted()
      rejected = @rejected()

      return {
        accepted: accepted
        rejected: rejected
        error: @collection.error
        class: @collection.class
      }


    events:
      'click .submit': 'acceptOrRejectRoles'
      'click input[type="radio"]': 'onClickSetHasAcceptedForRole'


    initialize: () ->
      @listenTo(@collection, 'reset', @render)
      @listenTo(@collection, 'change:hasAcceptedLicense change:hasAccepted', @render)


    onRender: () ->
      @showAcceptedAndRejected()
      @disableLicenseCheckboxIfRolesRejected()


    onClickSetHasAcceptedForRole: (e) ->
      model = @collection.at(0)
      current = $(e.currentTarget)
      roles = model?.get('roles')
      requestedRole = current.closest('tr').attr('data-requested-role')
      selectedRole = _.find roles, (role) -> role.role is requestedRole
      selectedRole.hasAccepted = current.val()
      @disableLicenseCheckboxIfRolesRejected()


    disableLicenseCheckboxIfRolesRejected: () ->
      model = @collection.at(0)
      roles = model?.get('roles')
      row = $('tr.roles')
      isRejected = []
      _.each roles, (role) ->
        if role.hasAccepted is false or role.hasAccepted is 'false'
          isRejected.push(role.role)

      if row.length is isRejected.length
        $('.licenseCheckbox').attr({'checked': false, 'disabled': true})
      else
        $('.licenseCheckbox').attr('disabled', false)


    showAcceptedAndRejected: () ->
      model = @collection.at(0)
      roles = model?.get('roles')
      rows = $('table').find('tr.roles')

      _.each rows, (row) ->
        requestedRole = $(row).attr('data-requested-role')
        userPermissions = _.find roles, (role) -> role.role is requestedRole
        selectedRow = $(row).closest('tr')

        if userPermissions.role is requestedRole
          if userPermissions.hasAccepted is null
            userPermissions.hasAccepted = true
            selectedRow.find(':radio[value=true]').attr('checked', 'checked')
          else if userPermissions.hasAccepted is true
            selectedRow.find(':radio[value=true]').prop({'checked': 'checked'})
            $(row).addClass('gray')
          else if userPermissions.hasAccepted is false
            selectedRow.find(':radio[value=false]').prop({'checked': 'checked'})
            $(row).addClass('gray')


    acceptLicense: (model) ->
      if $('.licenseCheckbox').is(':checked')
        model.set('hasAcceptedLicense', true)
      else
        model.set('hasAcceptedLicense', false)


    acceptOrRejectRoles: () ->
      model = @collection.at(0)
      roleRequests= []
      @acceptLicense(model)
      rolesList = model?.get('roles')
      data = {'license': model.get('hasAcceptedLicense'), 'roles': roleRequests}
      isAccepted = []

      _.each rolesList, (role) ->
        if role.hasAccepted is 'true' or role.hasAccepted is true
          isAccepted.push(role)
        roles = {'role': role.role, 'hasAccepted': role.hasAccepted}
        roleRequests.push(roles)

      if isAccepted.length > 0  and model.get('hasAcceptedLicense') is false
        alert 'You must accept the license.'
      else
        @collection.acceptOrReject(data)


    accepted: () ->
      @message(true, 'accepted')


    rejected: () ->
      @message(false, 'rejected')


    message: (acceptedBool, messageModel) ->
      model = @collection?.at(0)
      role = _.map model?.get('roles'), (role) -> role
      accepted = _.where(role, {'hasAccepted': acceptedBool})
      roles = []
      url = "#{location.protocol}//#{location.host}/contents/#{model?.id}@draft"

      _.each accepted, (role) =>
        roles.push(@formatRoles(role.role))

      if acceptedBool is false
        message = "The following Roles were rejected: #{roles}."
      else
        message = "The following Roles were accepted: #{roles}.
                   <a href=\"#{url}\">You can view the content</a> or access it from your Workspace."

      if roles.length > 0
        model.set(messageModel, message)
        return model.get(messageModel)
      else
        return ''


    formatRoles: (str) ->
      cap = str.charAt(0).toUpperCase()
      format = str.substring(1).replace('_', ' ')
      return " #{cap}#{format}"
