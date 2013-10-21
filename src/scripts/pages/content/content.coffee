define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  HeaderView = require('cs!modules/header/header')
  FooterView = require('cs!modules/footer/footer')
  FindContentView = require('cs!modules/find-content/find-content')
  BrowseContentView = require('cs!modules/browse-content/browse-content')
  MediaView = require('cs!modules/media/media')
  template = require('hbs!./content-template')
  require('less!./content')

  return class ContentPage extends BaseView
    template: template

    initialize: (options) ->
      super()
      @uuid = options?.uuid
      @page = options?.page

    regions:
      content: '#content'

    onRender: () ->
      @parent.regions.header.show(new HeaderView({page: 'content'}))
      @parent.regions.footer.show(new FooterView({page: 'content'}))
      @regions.content.show(new FindContentView())

      if @uuid
        @regions.content.append(new MediaView({uuid: @uuid, page: @page}))
      else
        @regions.content.append(new BrowseContentView())
