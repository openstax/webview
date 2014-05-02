define (require) ->
  settings = require('settings')
  subjects = require('cs!collections/subjects')
  FooterTabView = require('cs!modules/media/footer/inherits/tab/tab')
  template = require('hbs!./metadata-template')
  require('less!./metadata')

  s2Defaults = width: 300
  s2Multi = _.extend {}, s2Defaults, minimumInputLength: 2

  return class MetadataView extends FooterTabView
    template: template
    templateHelpers: () ->
      model = super()
      model.languages = settings.languages
      model.languageName = settings.languages[model.language]
      model.subjectsList = subjects.list
      return model

    editable:
      '.language > select':
        value: () -> @getModel('language')
        type: 'select2'
        select2: s2Defaults
      '.summary':
        value: () -> @getModel('abstract')
        type: 'aloha'
      '.subjects > select':
        value: () -> @getModel('subjects')
        type: 'select2'
        select2: s2Defaults
      '.keywords > input':
        value: () -> @getModel('keywords')
        type: 'select2'
        select2: () ->
          @$el?.find('.keywords > input').val(@model.get(@getModel('keywords')) or [])
          _.extend({}, s2Multi, tags: @model?.get(@getModel('keywords')) or [])

    initialize: () ->
      super()
      @listenTo(@model, 'change change:currentPage', @render)

    getModel: (value) ->
      if @media is 'page' and @model.isBook() then return "currentPage.#{value}" else return value
