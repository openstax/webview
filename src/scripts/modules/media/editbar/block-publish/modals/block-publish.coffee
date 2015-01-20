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
      @listenTo(@model, 'change', @render)
      @listenTo(@model, 'change:publishBlockers', @render)
      @listenTo(@model, 'change:currentPage.publishBlockers', @render)

    publishBlockers: (model) ->
      book = model.isBook()
      title = model.get('title')
      isPublishable = model.get('isPublishable')
      contents = model.get('contents')?.models
      publishBlockers = model.get('publishBlockers')
      formatted = []

      if isPublishable is false
        _.each publishBlockers, (blockers) ->
          formatBlockers = blockers.replace('_', ' ')
          formatted.push("#{formatBlockers} in #{title}")

      if book and isPublishable
        _.each contents, (content) ->
          title = content.get('title')
          publishBlockers = content.get('publishBlockers')
          if publishBlockers isnt undefined and publishBlockers isnt null
            formatBlockers = publishBlockers[0].replace('_', ' ')
            formatted.push("#{formatBlockers} in #{title}")

      return formatted
