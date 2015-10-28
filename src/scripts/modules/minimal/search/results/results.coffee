define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  SearchHeaderView = require('cs!modules/search/header/header')
  SearchResultsFilterView = require('cs!modules/search/results/filter/filter')
  SearchResultsBreadcrumbsView = require('cs!modules/search/results/breadcrumbs/breadcrumbs')
  SearchResultsListView = require('cs!./list/list')
  template = require('hbs!./results-template')
  require('less!modules/search/results/results')

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
