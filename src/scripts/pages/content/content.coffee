define [
  'jquery'
  'underscore'
  'backbone'
  'cs!helpers/backbone/views/base'
  'cs!modules/header/header'
  'cs!modules/footer/footer'
  'cs!modules/media/media'
  'hbs!./content-template'
  'less!./content'
], ($, _, Backbone, BaseView, HeaderView, FooterView, MediaView, template) ->

  return class ContentView extends BaseView
    template: template()

    initialize: (options) ->
      super()

      if options?.uuid
        @uuid = options.uuid

    regions:
      content: '#content'

    render: () ->
      super()

      @parent?.regions.header.show(new HeaderView({page: 'content'}))
      @parent?.regions.footer.show(new FooterView({page: 'content'}))

      if @uuid
        @regions.content.show(new MediaView({uuid: @uuid}))

      return @
