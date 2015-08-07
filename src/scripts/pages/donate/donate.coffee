define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  HeaderView = require('cs!modules/header/header')
  FooterView = require('cs!modules/footer/footer')
  FindContentView = require('cs!modules/find-content/find-content')
  DefaultView = require('cs!./default/default')
  FormView = require('cs!./form/form')
  DownloadView = require('cs!./download/download')
  ThankYouView = require('cs!./thankyou/thankyou')
  template = require('hbs!./donate-template')
  require('less!./donate')

  return class DonatePage extends BaseView
    template: template
    pageTitle: 'Support OpenStax CNX'
    canonical: null
    next: null
    prev: null
    summary: 'Donate to OpenStax CNX'
    description: 'Donate to OpenStax CNX'

    regions:
      find: '.find'
      content: '.donate-content'

    initialize: (options = {}) ->
      super()
      @page = options.page
      @options =
        uuid: options.uuid
        type: options.type

    onRender: () ->
      @parent.regions.header.show(new HeaderView({page: 'donate'}))
      @parent.regions.footer.show(new FooterView({page: 'donate'}))
      @regions.find.show(new FindContentView())

      switch @page
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
