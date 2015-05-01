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

    events: {
      'click input[name="licenses"]': 'setLicense'
      'click .btn-submit': 'close'
    }

    initialize: (options) ->
      @listenTo(@collection, 'reset', @render)
      @parent = options.parent

    close: () ->
      @changeLicense()
      $('#license-modal').modal('hide')

    setLicense: () ->
      licenses = @collection.models
      selectedValue = @$el.find('input[name="licenses"]:checked').val()
      selectedLicense = ''
      _.each licenses, (license) ->
        if license.get('code') is selectedValue
          selectedLicense = license
      return selectedLicense

    changeLicense: () ->
      licenseModel = @parent.model.get('license')
      selectedLicense = @setLicense()
      license = new @parent.model.license

      if @parent.model.get('state') is 'Draft'
        @selectedLicense(license, licenseModel, selectedLicense)

      if @parent.model.get('contents')?.models.length
        pages = @parent.model.get('contents').models

        _.each pages, (page) ->
          if page.get('state') is 'Draft' or page.get('editable') is true
            newLicense = { 'code': licenseModel.code, 'name': licenseModel.name
            'url': licenseModel.url, 'version': licenseModel.version }
            page.set('license', newLicense)
            page.set('changed', true)

      @parent.model.set('changed', true)

    selectedLicense: (license, model, selectedLicense) ->
      license.setLicense(model.code = selectedLicense.get('code'))
      license.setLicense(model.name = selectedLicense.get('name'))
      license.setLicense(model.url = selectedLicense.get('url'))
      license.setLicense(model.version = selectedLicense.get('version'))
