define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  HeaderView = require('cs!modules/header/header')
  FooterView = require('cs!modules/footer/footer')
  FindContentView = require('cs!modules/find-content/find-content')
  BrowseContentView = require('cs!modules/browse-content/browse-content')
  MediaView = require('cs!modules/media/media')
  template = require('hbs!./contents-template')
  require('less!./contents')

  return class ContentsPage extends BaseView
    template: template
    pageTitle: 'Content Library'

    initialize: (options) ->
      super()
      @uuid = options?.uuid
      @page = options?.page

    regions:
      contents: '#contents'

    onRender: () ->
      @parent.regions.header.show(new HeaderView({page: 'contents', url: 'contents'}))
      @parent.regions.footer.show(new FooterView({page: 'contents'}))
      @regions.contents.show(new FindContentView())

      if @uuid
        @regions.contents.append(new MediaView({uuid: @uuid, page: @page}))
      else
        @regions.contents.append(new BrowseContentView())
