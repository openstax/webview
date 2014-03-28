define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  SearchHeaderView = require('cs!../header/header')
  SearchResultsListView = require('cs!./list/list')
  template = require('hbs!./results-template')
  require('less!./results')

  return class WorkspaceSearchResultsView extends BaseView
    template: template

    regions:
      header: '.header'
      list: '.list'

    onRender: () ->
      @regions.header.show(new SearchHeaderView({model: @model}))
      @regions.list.show(new SearchResultsListView({model: @model}))
