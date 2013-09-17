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
      'click .dropdown-toggle': 'clickToggle'
      'keyup input': 'triggerSearch'

    clickToggle: (e) ->
      e.preventDefault()

    triggerSearch: (e) ->
      if e.keyCode is 13
        @search($(e.currentTarget).val())
    
    search: (query) ->
      router.navigate("search?q=#{query}", {trigger: true})
