define (require) ->
  $ = require('jquery')
  router = require('cs!router')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./breadcrumbs-template')
  require('less!./breadcrumbs')

  QUERY_NAMES = {
    "author": "Author"
    "authorID": "Author ID"
    "keyword": "Keyword"
    "mediaType": "Type"
    "type": "Type"
    "pubYear": "Publication Date"
    "subject": "Subject"
    "title": "Title"
    "text": "Text"
  }

  capitalize = (str) ->
    return (str.split(' ').map (word) -> word[0].toUpperCase() + word[1..-1].toLowerCase()).join ' '

  return class SearchResultsBreadcrumbsView extends BaseView
    template: template
    templateHelpers: () ->
      limits = @model.toJSON().queryFormatted?.limits

      queries = []
      _.each limits, (limit) ->
        _.each _.keys(limit), (key) ->
          queries.push
            limit: key
            value: limit[key]
            name: QUERY_NAMES[key] or capitalize(key)

      return {queries: queries}

    events:
      'click .remove': 'removeBreadcrumb'

    initialize: () ->
      super()
      @listenTo(@model, 'change:query', @render)

    removeBreadcrumb: (e) ->
      limits = @model.get('query').limits
      limits.splice($(e.currentTarget).parent().data('index'), 1)

      query = @formatQuery(limits)
      @search(query)

    search: (query) ->
      router.navigate("search?q=#{query}", {trigger: true})

    # Transform the query.limits object into the original query string
    formatQuery: (obj) ->
      format = (obj) ->
        _.map obj, (limit) ->
          key = _.keys(limit)[0]

          # Values with spaces in them must have been surrounded by quote strings
          if /\s/g.test(limit[key]) and not /"/g.test(limit[key])
            limit[key] = "\"#{limit[key]}\""

          return "#{key}:#{limit[key]}" # Limit strings are in the format `limit:value`

      return _.compact(_.flatten(format(obj))).join(' ')
