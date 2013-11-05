define (require) ->
  subjects = require('cs!collections/subjects')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./browse-content-template')
  require('less!./browse-content')

  return class BrowseContentView extends BaseView
    collection: subjects
    template: template

    initialize: () ->
      super()
      @listenTo(@collection, 'reset', @render)
