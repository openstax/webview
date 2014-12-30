define (require) ->
  $ = require('jquery')
  linksHelper = require('cs!helpers/links')
  router = require('cs!router')
  subjects = require('cs!collections/subjects')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./find-content-template')
  require('less!./find-content')
  require('bootstrapDropdown')

  return class FindContentView extends BaseView
    template: template
    collection: subjects

    events:
      'click .dropdown-menu > li': 'selectSubject'
      'keyup input, click .find': 'triggerSearch'

    initialize: () ->
      super()
      @listenTo(@collection, 'reset', @render)

    onRender: () ->
      @updateSearchBar()

    selectSubject: (e) ->
      e.preventDefault()

      @search("subject:\"#{$(e.currentTarget).text()}\"")

    triggerSearch: (e) ->
      if e.keyCode is 13
        @search(encodeURIComponent($(e.currentTarget).val()))

    search: (query) ->
      router.navigate("search?q=#{query}", {trigger: true})

    updateSearchBar: () ->
      queryString = linksHelper.serializeQuery(location.search)
      @$el.find('.find').val(queryString.q)
