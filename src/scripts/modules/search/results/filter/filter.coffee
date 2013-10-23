define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./filter-template')
  require('less!./filter')

  FILTER_NAMES = {
    "author": "Author"
    "keyword": "Keyword"
    "mediaType": "Type"
    "pubYear": "Publication Date"
    "subject": "Subject"
  }

  capitalize: (str) ->
    return (str.split(' ').map (word) -> word[0].toUpperCase() + word[1..-1].toLowerCase()).join ' '

  return class SearchResultsFilterView extends BaseView
    template: template
    templateHelpers: () ->
      limits = @model.toJSON().results.limits

      filters = {}
      _.each limits, (limit) ->
        _.each _.keys(limit), (key) ->
          if key isnt 'count'
            filterName = FILTER_NAMES[key] or capitalize(key)
            name = limit[key]

            if name is 'application/vnd.org.cnx.collection' then name = 'book'
            else if name is 'application/vnd.org.cnx.module' then name = 'page'

            if key is 'mediaType' then key = 'type'

            if key is 'author'
              name = limit[key].fullname

            filters[filterName] = filters[filterName] or {}
            filters[filterName][name] = {count: limit['count'], filter: filterName, key: key, id: limit[key]?.id}

      return {filters: filters, url: Backbone.history.fragment}

    initialize: () ->
      super()
      @listenTo(@model, 'change:results', @render)
