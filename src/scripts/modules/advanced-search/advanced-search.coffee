define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./advanced-search-template')
  require('less!./advanced-search')

  return class AdvancedSearchView extends BaseView
    template: template
