define (require) ->
  settings = require('cs!settings')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./footer-template')
  require('less!./footer')

  return class FooterView extends BaseView
    template: template
    templateHelpers: () ->
      # Polyfill for location.origin since IE doesn't support it
      port = if location.port then ":#{location.port}" else ''
      location.origin = location.origin or "#{location.protocol}//#{location.hostname}#{port}"

      return {
        url: location.origin + settings.root
        webmaster: settings.webmaster
      }

    onRender: () ->
      height = @$el.find('.copyright').height()
      @$el.find('.connect').height(height)
      @$el.find('.share').height(height)
