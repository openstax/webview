define (require) ->
  _ = require('underscore')
  settings = require('settings')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./footer-template')
  socialMedia = require('cs!helpers/socialmedia')
  require('less!./footer')

  return class FooterView extends BaseView
    template: template
    templateHelpers: () ->
      location.origin = socialMedia.locationOriginPolyFillForIe()

      return {
        share: socialMedia.socialMediaInfo()
        legacy: settings.legacy
        url: location.origin + settings.root
        webmaster: settings.webmaster
      }

    onRender: () ->
      height = @$el.find('.copyright').height()
      @$el.find('.connect').height(height)
      @$el.find('.share').height(height)
