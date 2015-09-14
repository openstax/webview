define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')
  featuredBooks = require('cs!collections/featured-books')
  template = require('hbs!./featured-books-template')
  require('less!./featured-books')

  return class FeaturedBooksView extends BaseView
    template: template
    collection: featuredBooks
    title: 'Featured Books'

    initialize: () ->
      super()
      @listenTo(@collection, 'reset', @render)

    onBeforeClose: () ->
      $(window).off('resize.featuredBooks')
