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
    
    initialize: () ->
      super()
      @listenTo(@model, 'change', @render) if @model

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
