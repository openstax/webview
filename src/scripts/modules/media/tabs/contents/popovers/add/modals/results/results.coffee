define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  SearchResultsListView = require('cs!./list/list')
  template = require('hbs!./results-template')
  require('less!./results')

  return class AddPageSearchResultsView extends BaseView
    template: template

    regions:
      list: '.list'

    onRender: () ->
      @regions.list.show(new SearchResultsListView({model: @model}))
