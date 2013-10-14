define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./filter-template')
  require('less!./filter')

  return class SearchResultsFilterView extends BaseView
    template: template
    templateHelpers: () ->
      limits = @model.toJSON().results.limits

      filters = {}
      _.each limits, (limit) ->
        _.each _.keys(limit), (key) ->
          if key isnt 'count'
            name = limit[key]
            filterName = key
            if filterName is 'mediaType' then filterName = 'type'
            if name is 'application/vnd.org.cnx.collection' then name = 'book'
            else if name is 'application/vnd.org.cnx.module' then name = 'page'
            filters[filterName] = filters[filterName] or {}
            filters[filterName][name] = {count: limit['count'], filter: filterName}

      return {filters: filters, url: Backbone.history.fragment}

    initialize: () ->
      super()
      @listenTo(@model, 'change:results', @render)
