define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./block-publish-template')
  _ = require('underscore')
  require('less!./block-publish')

  return class BlockPublishModal extends BaseView
    template: template

    templateHelpers: () ->
      publishBlockers: @publishBlockers(@model)

    initialize: () ->
      @listenTo(@model, 'change:publishBlockers', @render)

    publishBlockers: (model) ->
      publishBlockers = model.get('publishBlockers')
      formatted = []

      _.each publishBlockers, (blockers) ->
        formatBlockers = blockers.replace('_', ' ')
        formatted.push(formatBlockers)

      return formatted
