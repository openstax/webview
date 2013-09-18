define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./filter-template')
  require('less!./filter')

  return class SearchFilterView extends BaseView
    template: template
