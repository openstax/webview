define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./header-template')
  require('less!./header')

  return class WorkspaceHeaderView extends BaseView
    template: template

