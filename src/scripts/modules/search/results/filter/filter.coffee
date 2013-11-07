define (require) ->
  $ = require('jquery')
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

  capitalize = (str) ->
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

            if name is 'application/vnd.org.cnx.collection' then name = 'collection'
            else if name is 'application/vnd.org.cnx.module' then name = 'module'

            if key is 'mediaType' then key = 'type'

            if key is 'author'
              name = limit[key].fullname

            filters[filterName] = filters[filterName] or {}
            filters[filterName]._index = filters[filterName]._index or 0
            filters[filterName]._index++
            filters[filterName][name] =
              count: limit['count']
              filter: filterName
              key: key
              index: filters[filterName]._index
              id: limit[key]?.id
              url: Backbone.history.fragment

      return {filters: filters}

    events:
      'click .toggle': 'toggleLimits'

    initialize: () ->
      super()
      @listenTo(@model, 'change:results', @render)

    onRender: () ->
      @$el.find('.collapsed').append('<li class="toggle"><span class="text">More...</span></li>')

    toggleLimits: (e) ->
      $target = $(e.currentTarget)
      $limits = $target.siblings('.overflow')
      $text = $target.children('.text')

      if @expanded
        $limits.addClass('hidden')
        $text.text('More...')
        $text.removeClass('less')
        @expanded = false
      else
        $limits.removeClass('hidden')
        $text.text('Less...')
        $text.addClass('less')
        @expanded = true
