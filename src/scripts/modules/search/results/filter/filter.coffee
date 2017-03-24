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

    toggleLimit: ($target) ->
      $limits = $target.siblings('.overflow')
      $text = $target.children('.text')
      name = $text.data('name')

      if $text.attr('aria-expanded') is 'true'
        $limits.addClass('hidden')
        $text.removeClass('less')
        $text.attr('aria-expanded', 'false')
        $text.attr('data-l10n-args', '{"ismore": 0}')

      else
        $limits.removeClass('hidden')
        $text.addClass('less')
        $text.attr('aria-expanded', 'true')
        $text.attr('data-l10n-args', '{"ismore": 1}')

    toggleLimits: (e) ->
      $target = $(e.currentTarget)
      @toggleLimit($target)

    toggleLimitsKeyboard: (e) ->
      if e.keyCode is 13 or e.keyCode is 32
        e.preventDefault()
        $target = $(e.currentTarget)
        @toggleLimit($target)
