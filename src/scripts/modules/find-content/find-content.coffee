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
    pageTitle: 'search-pageTitle'
    template: template
    collection: subjects

    events:
      'click .dropdown-menu > li': 'selectSubject'
      'keyup input, click .find': 'handleKeyDown'
      'click .fa-search': 'triggerSearch'

    initialize: () ->
      super()
      @listenTo(@collection, 'reset', @render)

    onRender: () ->
      @$el.addClass('find-content')
      @updateSearchBar()

    selectSubject: (e) ->
      e.preventDefault()
      @search("subject:\"#{$(e.currentTarget).text()}\"")

    triggerSearch: (e) ->
      search = @$el.find('input').val()
      @search(encodeURIComponent(search)) if search

    handleKeyDown: (e) ->
      if e.keyCode is 13
        @triggerSearch(e)

    search: (query) ->
      router.navigate("search?q=#{query}", {trigger: true})

    updateSearchBar: () ->
      queryString = linksHelper.serializeQuery(location.search)
      @$el.find('.find').val(queryString.q)
