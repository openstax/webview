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
      roles = _.map model?.get('roles'), (role) -> role
      rows = $('table').find('tr.roles')
      accept = $(':radio[value=accept]')
      reject = $(':radio[value=reject]')

      _.each rows, (row) ->
        requestedRole = $(row).attr('data-requested-role')
        hasAccepted = _.where(roles, {'role' : requestedRole})
        if hasAccepted[0].role is requestedRole
          if hasAccepted[0].hasAccepted is null
            accept.attr('checked', 'checked')
          else if hasAccepted[0].hasAccepted is true
            accept.prop({'checked': true, 'disabled': 'disabled'})
            reject.prop('disabled','disabled')
            $(row).addClass('gray')
            $('.btn').prop('disabled', true)
          else if hasAccepted[0].hasAccepted is false
            reject.prop({'checked': true, 'disabled': 'disabled'})
            accept.prop('disabled','disabled')
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
      data = {"license": model.get('hasAcceptedLicense'), "roles": roleRequests}
      rows = $('table').find('tr.roles')
      isAccepted = false

      _.each rows, (row) ->
        acceptOrReject = $('input[type="radio"]:checked').val()
        requestedRole = $(row).attr('data-requested-role')
        if acceptOrReject is 'accept' and model.get('hasAcceptedLicense')
          isAccepted = true
          model.set('hasAccepted', true)
        else if acceptOrReject is 'accept' and not model.get('hasAcceptedLicense')
          isAccepted = false
        else if acceptOrReject is 'reject'
          isAccepted = true
          model.set('hasAccepted', false)

        roles = {"role": requestedRole, "hasAccepted": model.get('hasAcceptedLicense')}
        roleRequests.push(roles)

      if isAccepted
        @collection.acceptOrReject(data)
      else
        alert 'You must accept the license'



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
