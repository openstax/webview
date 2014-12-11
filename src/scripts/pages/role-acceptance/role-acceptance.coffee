define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  HeaderView = require('cs!modules/header/header')
  FooterView = require('cs!modules/footer/footer')
  FindContentView = require('cs!modules/find-content/find-content')
  template = require('hbs!./role-acceptance-template')
  RoleAcceptancesView = require('cs!modules/role-acceptances/role-acceptances')

  require('less!./role-acceptance')

  return class RoleAcceptance extends BaseView
    template: template
    templateHelpers: () ->
      pageTitle: 'Role Acceptance'

    regions:
      roleAcceptances: '.role-acceptances-wrapper'
      find: '.find'

    onRender: () ->
      @parent.regions.header.show(new HeaderView())
      @parent.regions.footer.show(new FooterView())
      @regions.find.show(new FindContentView())
      @regions.roleAcceptances.show(new RoleAcceptancesView())
