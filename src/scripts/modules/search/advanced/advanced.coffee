define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  settings = require('settings')
  router = require('cs!router')
  SearchHeaderView = require('cs!../header/header')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./advanced-template')
  availableLanguages = require('cs!collections/languages')
  require('less!./advanced')

  # Move this to helpers?
  parseQuery = (locationString) ->
    query = {}
    criteriaMatch = decodeURI(locationString.substr(1))
    .match(/criteria=(.*)/)
    if criteriaMatch
      criteriaPart = criteriaMatch[1]
      .match(///
      (\w+:   # query field, colon
        (     # Series of...
          (?:.(?!\w+:))+  # character not followed by query field+colon
        )
      )
      ///g)
      if criteriaPart? then $.each(criteriaPart, (i, entry) ->
        pair = entry.split(':', 2)
        valueNoQuotes = pair[1].match(/[^"]+/)
        query[pair[0]] = valueNoQuotes[0]
        )
    query

  return class AdvancedSearchView extends BaseView
    template: template
    pageTitle: 'advanced-search-pageTitle'
    collection: availableLanguages
    templateHelpers:
      languages: () ->
        if availableLanguages.models?
          return availableLanguages.models
        return settings.languages
      filtered: () ->
        if availableLanguages.models? then return true else false
      years: [(new Date).getFullYear()..1999]

    regions:
      header: '.header'

    events:
      'submit form': 'submitForm'
    initialize: () ->
      super()
      @criteria = parseQuery(window.location.search)
      @listenTo(@collection, 'reset', @render)

    onRender: () ->
      @regions.header.show(new SearchHeaderView())
      $.each(@criteria, (name, value) =>
        $item = @$el.find("[name^=\"#{name}\"]")
        $item.val(value)
        )

    submitForm: (e) ->
      e.preventDefault()

      $form = $(e.currentTarget)
      values = $form.serializeArray()
      query = @formatQuery(values)

      @search(query)

    search: (query) ->
      router.navigate("search?q=#{query}", {trigger: true})

    formatQuery: (obj) ->
      format = (obj) ->
        _.map obj, (limit, index) ->
          if not limit.value then return

          # Split keywords into multiple keyword:value pairs
          if limit.name is 'keywords'
            keywords = limit.value.match(/(?:[^\s"]+|"[^"]*")+/g)
            keywords = _.map keywords, (value) -> {name: 'keyword', value: value}
            return format(keywords)

          if /\s/g.test(limit.value) and not /"/g.test(limit.value)
            limit.value = "\"#{limit.value}\""

          return "#{limit.name}:#{limit.value}"

      return _.compact(_.flatten(format(obj))).join(' ')
