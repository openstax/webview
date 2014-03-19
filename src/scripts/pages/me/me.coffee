define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  HeaderView = require('cs!modules/header/header')
  FooterView = require('cs!modules/footer/footer')
  WorkspaceView = require('cs!modules/workspace/workspace')
  template = require('hbs!./me-template')
  require('less!./me')

  return class MePage extends BaseView
    template: template
    pageTitle: 'My Workspace'

    regions:
      me: '#me'

    onRender: () ->
      @parent.regions.header.show(new HeaderView({page: 'me', url: 'mycnx'}))
      @parent.regions.footer.show(new FooterView({page: 'me'}))

      @regions.me.append(new WorkspaceView())
