define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./breadcrumbs-template')
  require('less!./breadcrumbs')

  return class SearchBreadcrumbsView extends BaseView
    template: template
