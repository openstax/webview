define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./find-content-template')
  require('less!./find-content')
  require('bootstrapDropdown')

  return class FindContentView extends BaseView
    template: template()

    events:
      'click .dropdown-toggle': 'clickToggle'

    clickToggle: (e) ->
      e.preventDefault()
