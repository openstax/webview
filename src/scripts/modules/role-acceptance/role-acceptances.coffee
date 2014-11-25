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


    initialize: () ->
      @listenTo(@collection, 'reset', @render)
      @listenTo(@collection, 'change:hasAcceptedLicense change:hasAccepted', @render)


    onRender: () ->
      @showAcceptedAndRejected()


    showAcceptedAndRejected: () ->
      model = @collection.at(0)
      rolesCheckbox = $('.rolesCheckbox')
      roles = _.map model?.get('roles'), (role) -> role

      _.each rolesCheckbox, (check) ->
        requestedRole = $(check).attr('data-requested-role')
        hasAccepted = _.where(roles, {'role' : requestedRole})
        row = $(check).closest('tr')
        if hasAccepted[0].role is requestedRole
          if hasAccepted[0].hasAccepted
            $(check).prop({'checked': true, 'disabled': 'disabled'})
            row.addClass('gray')
            $('.btn').prop('disabled', true)
          else if hasAccepted[0].hasAccepted is false
            $(check).prop('disabled', 'disabled')
            row.addClass('gray')
          else if hasAccepted[0].hasAccepted is null
            $('.btn').prop('disabled', false)


    acceptLicense: (model) ->
      if $('.licenseCheckbox').is(':checked')
        model.set('hasAcceptedLicense', true)
      else
        model.set('hasAcceptedLicense', false)


    acceptOrRejectRoles: () ->
      model = @collection.at(0)
      rolesCheckbox = $('.rolesCheckbox')
      roleRequests= []
      @acceptLicense(model)
      data = {"license": model.get('hasAcceptedLicense'), "roles": roleRequests}

      _.each rolesCheckbox, (role) ->
        requestedRole = $(role).attr('data-requested-role')
        if $(role).is(':checked') and model.get('hasAcceptedLicense')
          model.set('hasAccepted', true)
        else
          model.set('hasAccepted', false)
        roles = {"role": requestedRole, "hasAccepted": model.get('hasAccepted')}
        roleRequests.push(roles)

      @collection.acceptOrReject(data)


    accepted: () ->
      @message(true, 'accepted')


    rejected: () ->
      @message(false, 'rejected')


    message: (acceptedBool, messageModel) ->
      model = @collection?.at(0)
      role = _.map model?.get('roles'), (role) -> role
      accepted = _.where(role, {'hasAccepted' : acceptedBool})
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
      format = str.substring(1).replace('_',' ')
      return " #{cap}#{format}"
