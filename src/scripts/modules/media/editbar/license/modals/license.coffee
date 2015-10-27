define (require) ->
  settings = require('settings')
  BaseView = require('cs!helpers/backbone/views/base')
  Licenses = require('cs!collections/licenses')
  template = require('hbs!./license-template')

  authoringport = if settings.cnxauthoring.port then ":#{settings.cnxauthoring.port}" else ''
  PUBLISHING = "#{location.protocol}//#{settings.cnxauthoring.host}#{authoringport}/publish"

  return class LicenseView extends BaseView
    template: template
    collection: Licenses
    templateHelpers: () ->
      title: @parent.model.get('title')
      isBook: if @parent.model.get('mediaType') is 'application/vnd.org.cnx.collection' then true
      license: @parent.model.get('license')

    events:
      'click input[name="licenses"]': 'setLicense'
      'click .btn-submit': 'close'

    initialize: (options) ->
      @listenTo(@collection, 'reset', @render)
      @parent = options.parent

    close: () ->
      @changeLicense()
      $('#license-modal').modal('hide')

    setLicense: () ->
      licenses = @collection.models
      selectedValue = @$el.find('input[name="licenses"]:checked').val()
      selectedLicense = _.find licenses, (license) ->
        versionedCode = "#{license.get('code')}-#{license.get('version')}"
        if versionedCode is selectedValue
          return license

      if not selectedLicense
        selectedLicense =
          url: "http://cnx.org"
          code: "unknown"
          name: "Unknown License"
          version: "0.1"
          isValidForPublication: false
        console.warn "No license found matching the selected value #{selectedValue} for #{@parent.model.get('id')}"

      return selectedLicense

    changeLicense: () ->
      licenseModel = @parent.model.get('license')
      selectedLicense = @setLicense()

      if @parent.model.get('state') is 'Draft'
        @selectedLicense(licenseModel, selectedLicense)

      if @parent.model.get('contents')?.models.length
        pages = @parent.model.get('contents').models

        _.each pages, (page) ->
          if page.get('state') is 'Draft' or page.get('editable') is true
            newLicense = { 'code': licenseModel.code, 'name': licenseModel.name
            'url': licenseModel.url, 'version': licenseModel.version }
            page.set('license', newLicense)
            page.set('changed', true)

      @parent.model.set('changed', true)
      @parent.model.set('licenseCode', @parent.model.get('license').code)

    selectedLicense: (model, selectedLicense) ->
      model.code = selectedLicense.get?('code')
      model.name = selectedLicense.get?('name')
      model.url = selectedLicense.get?('url')
      model.version = selectedLicense.get?('version')
