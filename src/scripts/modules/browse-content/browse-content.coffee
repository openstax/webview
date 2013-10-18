define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./browse-content-template')
  require('less!./browse-content')

  return class BrowseContentView extends BaseView
    template: template
