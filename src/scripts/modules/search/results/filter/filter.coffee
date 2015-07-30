define (require) ->
  $ = require('jquery')
  linksHelper = require('cs!helpers/links')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./filter-template')
  require('less!./filter')

  return class SearchResultsFilterView extends BaseView
    template: template
    templateHelpers:
      url: () ->
        queryString = linksHelper.serializeQuery(window.location.search)
        q = queryString.q
        delete queryString.page
        delete queryString.q

        params = linksHelper.param(queryString)
        params += '&' if params

        url = "#{location.pathname}?#{params}q=#{q}"

        return url

    events:
      'click .toggle, keydown .toggle': 'toggleLimits'
      'keydown .toggle': 'toggleLimitsKeyboard'

    initialize: () ->
      super()
      @listenTo(@model, 'change:results', @render)

    onRender: () ->
      @$el.find('.collapsed').append('<li class="toggle"><span class="text" tabindex="0">More...</span></li>')

    toggleLimit: ($target) ->
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

    toggleLimits: (e) ->
      $target = $(e.currentTarget)
      @toggleLimit($target)

    toggleLimitsKeyboard: (e) ->
      if e.keyCode is 13 or e.keyCode is 32
        $target = $(e.currentTarget)
        @toggleLimit($target)
