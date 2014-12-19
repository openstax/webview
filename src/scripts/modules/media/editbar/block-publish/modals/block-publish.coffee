define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./block-publish-template')
  require('less!./reject-publish')

  return class BlockPublishModal extends BaseView
    template: template

    templateHelpers: () ->
      reasons: 'reasons' #@model.get('publishBlockers')
