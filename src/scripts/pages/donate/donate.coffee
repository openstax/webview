define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  MainPageView = require('cs!modules/main-page/main-page')
  DefaultView = require('cs!./default/default')
  FormView = require('cs!./form/form')
  DownloadView = require('cs!./download/download')
  ThankYouView = require('cs!./thankyou/thankyou')
  template = require('hbs!./donate-template')
  require('less!./donate')

  class InnerView extends BaseView
    template: template

    regions:
      content: '.donate-content'

    initialize: (@options) ->
      super()

    onRender: () ->
      switch @options.page
        when 'download'
          @regions.content.show new DownloadView
            uuid: @options.uuid
            type: @options.type
        when 'form'
          @regions.content.show(new FormView())
        when 'thankyou'
          @regions.content.show new ThankYouView
            uuid: @options.uuid
            type: @options.type
        else
          @regions.content.show(new DefaultView())

  return class DonatePage extends MainPageView
    pageTitle: 'Support OpenStax CNX'
    canonical: null
    summary: 'Donate to OpenStax CNX'
    description: 'Donate to OpenStax CNX'

    initialize: (@options) ->
      super()

    onRender: () ->
      super()
      @regions.main.show(new InnerView(@options))
