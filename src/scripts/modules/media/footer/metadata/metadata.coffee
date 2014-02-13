define (require) ->
  settings = require('settings')
  FooterTabView = require('cs!../inherits/tab/tab')
  template = require('hbs!./metadata-template')
  require('less!./metadata')

  return class MetadataView extends FooterTabView
    template: template
    templateHelpers: () ->
      model = super()
      model.languages = settings.languages
      return model

    editable:
      '.js-metadata-language-select':
        value: if @media is 'book' then 'currentPage.language' else 'language'
        type: 'select2'
        select2:
          width: 300

    initialize: () ->
      super()
      @listenTo(@model, 'change:editable', @render)
