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


    onClickSetHasAcceptedForRole: (e) ->
      model = @collection.at(0)
      current = $(e.currentTarget)
      roles = model?.get('roles')
      requestedRole = current.closest('tr').attr('data-requested-role')
      selectedRole = _.find roles, (role) -> role.role is requestedRole
      selectedRole.hasAccepted = current.val()


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
            selectedRow.find(':radio[value=true]').attr('checked', 'checked')
          else if userPermissions.hasAccepted is true
            selectedRow.find(':radio[value=true]').prop({'checked': 'checked'})
            selectedRow.find(':radio').prop({'disabled': 'disabled'})
            $(row).addClass('gray')
            $('.btn').prop('disabled', true)
          else if userPermissions.hasAccepted is false
            selectedRow.find(':radio[value=false]').prop({'checked': 'checked'})
            selectedRow.find(':radio').prop({'disabled': 'disabled'})
            $(row).addClass('gray')
            $('.btn').prop('disabled', true)


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
      isAccepted = false
      data = {'license': model.get('hasAcceptedLicense'), 'roles': roleRequests}
      isAccepted = _.find rolesList, (role) ->
        role.hasAccepted is 'true' or role.hasAccepted is null

      _.each rolesList, (role) ->
        roles = {'role': role.role, 'hasAccepted': role.hasAccepted}
        if role.hasAccepted is null
          role.hasAccepted = true
        roleRequests.push(roles)


      if isAccepted isnt undefined and model.get('hasAcceptedLicense') is false
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
