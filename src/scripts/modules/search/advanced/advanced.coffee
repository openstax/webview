define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./advanced-template')
  require('less!./advanced')

  return class AdvancedSearchView extends BaseView
    template: template
