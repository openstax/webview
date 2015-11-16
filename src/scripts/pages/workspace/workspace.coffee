define (require) ->
  MainPageView = require('cs!modules/main-page/main-page')
  WorkspaceView = require('cs!modules/workspace/workspace')
  require('less!./workspace')

  return class WorkspacePage extends MainPageView
    pageTitle: 'My Workspace'
    canonical: null
    summary: 'Add new content or find content and derive a copy for editing.'
    description: 'Create free educational content, or derive a copy for editing.'

    onRender: () ->
      super()
      @regions.main.show(new WorkspaceView())
