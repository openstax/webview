define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./metadata-template')
  require('less!./metadata')

  LICENSES = {
    'by': 'Attribution License CC BY'
    'by-sa': 'Attribution-ShareAlike CC BY-SA'
    'by-nd': 'Attribution-NoDerivs CC BY-ND'
    'by-nc': 'Attribution-NonCommercial CC BY-NC'
    'by-nc-sa': 'Attribution-NonCommercial-ShareAlike CC BY-NC-SA'
    'by-nc-nd': 'Attribution-NonCommercial-NoDerivs CC BY-NC-ND'
  }

  return class MetadataView extends BaseView
    template: template
    templateHelpers:
      currentPageLicense: () ->
        page = @model.get('currentPage')
        license = page?.get('license')?.match(/^http:\/\/creativecommons\.org\/licenses\/(.+)\/(.+)\//)

        if _.isArray(license) and license.length > 1
          return {type: "Creative Commons #{LICENSES[license[1]]}", version: license[2]}

        return {type: null, version: null}

    initialize: () ->
      super()
      @listenTo(@model, 'changePage changePage:content', @render)
