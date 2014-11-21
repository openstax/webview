define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./role-acceptance-template')
  RoleAcceptances = require('cs!collections/role-acceptances')
  $ = require('jquery')
  settings = require('settings')
  require('less!./role-acceptance')
  _ = require('underscore')

  AUTHORING = "#{location.protocol}//#{settings.cnxauthoring.host}:#{settings.cnxauthoring.port}"

  return  class RoleAcceptanceView extends BaseView
    template: template
    collection: RoleAcceptances

    events:
      'click .accept, .reject': 'acceptOrRejectRoleAndLicense'

    initialize: () ->
      @listenTo(@collection, 'reset', @render)
      @listenTo(@collection, 'change:hasAccepted change:hasAcceptedLicense', @render)
      @listenTo(@collection, 'change:loaded', @setClass)

    onRender: () ->
      @setClass

    setClass: () ->
      isPending = $('*[data-has-accepted=""]')
      hasRejected = $('*[data-has-accepted="false"]')
      isPending.addClass('pending')
      hasRejected.addClass('hasRejected')


    acceptOrRejectRoleAndLicense: (e) ->
      e.preventDefault()
      target = $(e.currentTarget)
      checked = target.closest('tr').find('input[type="checkbox"]')
      model = @collection.at(0)
      model.set('hasAccepted', false)
      model.set('hasAcceptedLicense', false)

      if target.hasClass('accept')
        model.set('hasAccepted', true)
        model.set('hasAcceptedLicense', true)

      if checked.is(':checked')
        hasAccepted = model.get('hasAccepted')
        license = model.get('hasAcceptedLicense')
        role = checked.attr('data-role-acceptance')
        data = {"license": license, "roles": [{"role": role, "hasAccepted": hasAccepted}]}

        @collection.acceptOrReject(data)
