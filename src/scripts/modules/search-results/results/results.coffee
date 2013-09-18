define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./results-template')
  require('less!./results')

  return class SearchResultsView extends BaseView
    template: template
