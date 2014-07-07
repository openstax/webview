define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./filter-template')
  require('less!./filter')

  return class SearchResultsFilterView extends BaseView
    template: template
    templateHelpers:
      url: () ->
        q = ""
        url = window.location.pathname + '?'
        url += _.filter window.location.search.slice(1).split('&'), (query) ->
          if query.substr(0,2) is 'q='
            q = query
            return false

          return true
        .join('&') + "&#{q}"

        return url

    events:
      'click .toggle': 'toggleLimits'

      # TODO: Fix filter links to work with page/per_page query paramters

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
