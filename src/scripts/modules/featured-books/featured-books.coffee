define (require) ->
  $ = require('jquery')
  Backbone = require('backbone')
  BaseView = require('cs!helpers/backbone/views/base')
  featuredOpenStaxBooks = require('cs!collections/featured-openstax-books')
  featuredCNXBooks = require('cs!collections/featured-cnx-books')
  template = require('hbs!./featured-books-template')
  require('less!./featured-books')

  return class FeaturedBooksView extends BaseView
    template: template
    collection: new Backbone.Collection
    title: 'Featured Books'

    initialize: () ->
      super()
      @listenTo(featuredOpenStaxBooks, 'reset', @render)
      @listenTo(featuredCNXBooks, 'reset', @render)

    render: () ->
      @collection.reset(featuredOpenStaxBooks.models)
      @collection.add(featuredCNXBooks.models)
      return super()

    onBeforeClose: () ->
      $(window).off('resize.featuredBooks')
