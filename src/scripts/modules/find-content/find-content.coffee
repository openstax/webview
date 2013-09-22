define (require) ->
  $ = require('jquery')
  router = require('cs!router')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./find-content-template')
  require('less!./find-content')
  require('bootstrapDropdown')

  return class FindContentView extends BaseView
    template: template

    events:
      'click .dropdown-menu > li': 'selectSubject'
      'keyup input': 'triggerSearch'

    selectSubject: (e) ->
      e.preventDefault()

      @search("subject:\"#{$(e.currentTarget).text()}\"")

    triggerSearch: (e) ->
      if e.keyCode is 13
        @search($(e.currentTarget).val())

    search: (query) ->
      router.navigate("search?q=#{query}", {trigger: true})
