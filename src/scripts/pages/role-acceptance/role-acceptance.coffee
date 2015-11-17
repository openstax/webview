define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  MainPageView = require('cs!modules/main-page/main-page')
  FindContentView = require('cs!modules/find-content/find-content')
  template = require('hbs!./role-acceptance-template')
  RoleAcceptancesView = require('cs!modules/role-acceptances/role-acceptances')
  require('less!./role-acceptance')

  class InnerView extends BaseView
    template: template
    templateHelpers: () ->
      pageTitle: 'Role Acceptance'

    regions:
      roleAcceptances: '.role-acceptances-wrapper'
      find: '.find'

    onRender: () ->
      @regions.find.show(new FindContentView())
      @regions.roleAcceptances.show(new RoleAcceptancesView())

  return class RoleAcceptance extends MainPageView
    onRender: ->
      super()
      @regions.main.show(new InnerView())
