define (require) ->
  settings = require('cs!settings')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./latest-template')
  require('less!./latest')

  return class LatestView extends BaseView
    template: template
    templateHelpers:
      url: () ->
        id = @model.get('id').split('@', 1)[0] # Remove the version from the id
        return "#{settings.root}contents/#{id}"

    initialize: () ->
      super()
      @listenTo(@model, 'change:isLatest', @render)
