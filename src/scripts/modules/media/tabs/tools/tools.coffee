define (require) ->
  router = require('cs!router')
  session = require('cs!session')
  linksHelper = require('cs!helpers/links')
  Page = require('cs!models/contents/page')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./tools-template')
  require('less!./tools')

  return class ToolsView extends BaseView
    template: template
    templateHelpers: () -> {
      authenticated: session.get('id')
      encodedTitle: encodeURI(@model.get('title'))
      derivable: not @model.isBook()
      isDraft: @model.isDraft()
    }

    events:
      'click .edit, .preview': 'toggleEditor'
      'click .derive': 'deriveCopy'

    initialize: () ->
      super()
      #@listenTo(@model, 'change:editable change:title', @render)
      @listenTo(session, 'change', @render)

    #toggleEditor: () ->
    #  @model.set('currentPage.editable', not @model.get('currentPage.editable'))
    #  @model.set('editable', not @model.get('editable'))

    #deriveCopy: () ->
    #  page = new Page
    #    derivedFrom: @model.getVersionedId()

    #  page.save()
    #  .fail(() -> alert('There was a problem deriving. Please try again'))
    #  .done () ->
    #    url = linksHelper.getPath('contents', {model: page})
    #    router.navigate(url, {trigger: true})
