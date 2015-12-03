define (require) ->
  subjects = require('cs!collections/subjects')
  BaseView = require('cs!helpers/backbone/views/base')
  MainPageView = require('cs!modules/main-page/main-page')
  FindContentView = require('cs!modules/find-content/find-content')
  template = require('hbs!./browse-content-template')
  require('less!./browse-content')

  class InnerView extends BaseView
    collection: subjects
    template: template

    initialize: () ->
      super()
      @listenTo(@collection, 'reset', @render)

    onRender: ->
      super()
      @$el.addClass('browse-content')

  return class BrowseContentView extends MainPageView

    onRender: () ->
      super()
      findContentView = new FindContentView()
      @regions.main.show(findContentView)
      @regions.main.append(new InnerView(@options))
