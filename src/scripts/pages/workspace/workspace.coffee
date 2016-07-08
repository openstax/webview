define (require) ->
  MainPageView = require('cs!modules/main-page/main-page')
  WorkspaceView = require('cs!modules/workspace/workspace')
  require('less!./workspace')

  return class WorkspacePage extends MainPageView
    pageTitle: 'workspace-pageTitle'
    canonical: null
    summary: 'workspace-summary'
    description: 'workspace-description'

    onRender: () ->
      super()
      @regions.main.show(new WorkspaceView())
