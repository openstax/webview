define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  MediaNavView = require('cs!./nav/nav')
  MediaHeaderView = require('cs!./header/header')
  MediaBodyView = require('cs!./body/body')
  MediaFooterView = require('cs!./footer/footer')
  template = require('hbs!./media-page-template')
  require('less!./media-page')

  return class MediaView extends BaseView
    template: template

    regions:
      contents: '.contents'

    templateHelpers: () ->
      status: @model.asPage()?.get('status')

    initialize: (@model) ->
      super()
      @listenTo(@model, 'change:status change:currentPage.status changePage', @render)

    onRender: () ->
      @regions.contents.append(new MediaHeaderView({model: @model}))
      @regions.contents.append(new MediaBodyView({model: @model}))
      @regions.contents.append(new MediaFooterView({model: @model}))
      @regions.contents.append(new MediaNavView({model: @model, hideProgress: true}))
