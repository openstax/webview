define (require) ->
  $ = require('jquery')
  _ = require('underscore')
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
      derivable: @model.canEdit()
      isEditable: @isEditable
      # FIX: Detect if an element actually has the class `os-teachers-edition`
      hasTeachersEdition: () => @model.get('content')?.indexOf('os-teachers-edition') >= 0
      isTeacher: @model.get('teacher')
    }

    events:
      'click .edit, .preview': 'toggleEditor'
      'click .derive': 'deriveCopy'
      'click .teacher-show, .teacher-hide': 'toggleTeacher'

    initialize: () ->
      super()
      @listenTo(@model, 'change:editable change:teacher change:title change:canPublish', @render)
      @listenTo(session, 'change', @render)

    toggleEditor: () -> @model.set('editable', not @model.get('editable'))

    toggleTeacher: () ->
      $els = $('.media-body > #content').find('.os-teachers-edition')
      @model.set('teacher', not @model.get('teacher'))

      if @model.get('teacher')
        $els.show()
      else
        $els.hide()

    deriveCopy: () ->
      page = new Page
        derivedFrom: @model.getVersionedId()

      page.save()
      .fail(() -> alert('There was a problem deriving. Please try again'))
      .done () ->
        url = linksHelper.getPath('contents', {model: page})
        router.navigate(url, {trigger: true})

    isEditable: () => _.indexOf(@model.get('permissions'), 'edit') >= 0

