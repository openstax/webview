define [
  'cs!helpers/backbone/views/base'
  'hbs!./find-content-template'
  'less!./find-content'
  'bootstrapDropdown'
], (BaseView, template) ->

  return class FindContentView extends BaseView
    template: template()

    events:
      'click .dropdown-toggle': 'clickToggle'

    clickToggle: (e) ->
      e.preventDefault()
