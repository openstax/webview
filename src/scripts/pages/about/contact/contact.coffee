define (require) ->
  settings = require('settings')

  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./contact-template')
  require('less!./contact')

  hasAuthoring = settings.hasFeature('authoring')

  return class AboutContactView extends BaseView
    templateHelpers:
      contact: if hasAuthoring then settings.webmaster else settings.support
      tech: settings.support
    template: template
