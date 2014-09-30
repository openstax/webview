define (require) ->
  linksHelper = require('cs!helpers/links')
  settings = require('settings')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./latest-template')
  require('less!./latest')

  return class LatestView extends BaseView
    template: template
    templateHelpers:
      url: () -> linksHelper.getModelPath(@model)

    initialize: () ->
      super()
      @listenTo(@model, 'change:isLatest change:currentPage', @render)
