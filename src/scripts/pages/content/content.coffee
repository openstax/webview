define [
  'jquery'
  'underscore'
  'backbone'
  'cs!helpers/backbone/views/base'
  'cs!modules/header/header'
  'cs!modules/footer/footer'
  #'cs!modules/splash/splash'
  'hbs!./content-template'
  'less!./content'
], ($, _, Backbone, BaseView, HeaderView, FooterView, template) ->

  return class ContentView extends BaseView
    template: template()

    regions:
      title: '#content-title'
      navTop: '#content-nav-top'
      header: '#content-header'
      body: '#content-body'
      footer: '#content-footer'
      navBottom: '#content-nav-bottom'

    render: () ->
      super()

      @parent?.regions.header.show(new HeaderView({page: 'content'}))
      @parent?.regions.footer.show(new FooterView({page: 'content'}))

      #@regions.title.show(new ContentTitleView({uuid: @uuid}))
      #@regions.navTop.show(new ContentNavView({uuid: @uuid}))
      #@regions.header.show(new ContentHeaderView({uuid: @uuid}))
      #@regions.body.show(new ContentBodyView({uuid: @uuid}))
      #@regions.footer.show(new ContentFooterView({uuid: @uuid}))
      #@regions.navBottom.show(new ContentNavView({uuid: @uuid}))

      return @
