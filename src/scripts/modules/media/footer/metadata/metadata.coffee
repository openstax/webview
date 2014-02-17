define (require) ->
  settings = require('settings')
  subjects = require('cs!collections/subjects')
  FooterTabView = require('cs!../inherits/tab/tab')
  template = require('hbs!./metadata-template')
  require('less!./metadata')

  s2Defaults = {width: 300}

  return class MetadataView extends FooterTabView
    template: template
    templateHelpers: () ->
      model = super()
      model.languages = settings.languages
      model.languageName = settings.languages[model.language]
      model.subjects = subjects.list
      return model

    editable:
      '.language > select':
        value: () -> if @media is 'book' then return 'language' else return 'currentPage.language'
        type: 'select2'
        select2: s2Defaults
      '.summary':
        value: () -> if @media is 'book' then return 'abstract' else return 'currentPage.abstract'
        type: 'contenteditable'
      '.subject > select':
        value: () -> if @media is 'book' then return 'subject' else return 'currentPage.subject'
        type: 'select2'
        select2: s2Defaults

    initialize: () ->
      super()
      @listenTo(@model, 'change:editable', @render)
