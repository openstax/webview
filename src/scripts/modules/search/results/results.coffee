define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  SearchHeaderView = require('cs!../header/header')
  SearchResultsFilterView = require('cs!./filter/filter')
  SearchResultsBreadcrumbsView = require('cs!./breadcrumbs/breadcrumbs')
  SearchResultsListView = require('cs!./list/list')
  template = require('hbs!./results-template')
  require('less!./results')

  return class SearchResultsView extends BaseView
    template: template

    regions:
      header: '.header'
      filter: '.filter'
      breadcrumbs: '.breadcrumbs'
      list: '.list'

    onRender: () ->
      @regions.header.show(new SearchHeaderView({model: @model}))
      @regions.filter.show(new SearchResultsFilterView({model: @model}))
      @regions.breadcrumbs.show(new SearchResultsBreadcrumbsView({model: @model}))
      @regions.list.show(new SearchResultsListView({model: @model}))
