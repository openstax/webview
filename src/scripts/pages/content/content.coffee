define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  HeaderView = require('cs!modules/header/header')
  FooterView = require('cs!modules/footer/footer')
  FindContentView = require('cs!modules/find-content/find-content')
  MediaView = require('cs!modules/media/media')
  template = require('hbs!./content-template')
  require('less!./content')

  return class ContentView extends BaseView
    template: template

    initialize: (options) ->
      super()

      @uuid = options?.uuid
      @page = options?.page

    regions:
      content: '#content'

    render: () ->
      super()

      @parent?.regions.header.show(new HeaderView({page: 'content'}))
      @parent?.regions.footer.show(new FooterView({page: 'content'}))

      if @uuid
        @regions.content.append(new FindContentView())
        @regions.content.append(new MediaView({uuid: @uuid, page: @page}))

      return @
