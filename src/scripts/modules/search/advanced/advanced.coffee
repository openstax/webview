define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  router = require('cs!router')
  SearchHeaderView = require('cs!../header/header')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./advanced-template')
  require('less!./advanced')

  return class AdvancedSearchView extends BaseView
    template: template

    regions:
      header: '.header'

    events:
      'submit form': 'submitForm'

    onRender: () ->
      @regions.header.show(new SearchHeaderView())

    submitForm: (e) ->
      e.preventDefault()

      $form = $(e.currentTarget)
      values = $form.serializeArray()
      query = @formatQuery(values)

      @search(query)

    search: (query) ->
      router.navigate("search?q=#{query}", {trigger: true})

    formatQuery: (obj) ->
      query = _.map obj, (limit, index) ->
        if not limit.value then return

        if /\s/g.test(limit.value) and not /"/g.test(limit.value)
          limit.value = "\"#{limit.value}\""

        return "#{limit.name}:#{limit.value}"

      return _.compact(query).join(' ')
