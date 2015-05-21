define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  HeaderView = require('cs!modules/header/header')
  FooterView = require('cs!modules/footer/footer')
  WorkspaceView = require('cs!modules/workspace/workspace')
  template = require('hbs!./workspace-template')
  require('less!./workspace')

  return class WorkspacePage extends BaseView
    template: template
    pageTitle: 'My Workspace'
    summary: 'Add new content or find content and derive a copy for editing.'
    description: 'Create free educational content, or derive a copy for editing.'

    regions:
      workspace: '#workspace'

    onRender: () ->
      @parent.regions.header.show(new HeaderView({page: 'workspace', url: 'mycnx'}))
      @parent.regions.footer.show(new FooterView({page: 'workspace'}))

      @regions.workspace.append(new WorkspaceView())
