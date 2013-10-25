define (require) ->
  $ = require('jquery')
  settings = require('cs!settings')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./header-template')
  require('less!./header')

  return class HeaderView extends BaseView
    template: template
    templateHelpers: () -> {
      page: @page
      url: @url
    }

    initialize: (options) ->
      super()
      @page = options?.page
      @url = options?.url or 'content'

    setLegacyLink: (url) ->
      @url = "#{settings.legacy}/#{url}"
      @render()
