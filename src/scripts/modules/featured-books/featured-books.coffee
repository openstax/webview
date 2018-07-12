define (require) ->
  $ = require('jquery')
  require('jqueryui')
  Backbone = require('backbone')
  BaseView = require('cs!helpers/backbone/views/base')
  featuredOpenStaxBooks = require('cs!collections/featured-openstax-books')
  featuredCNXBooks = require('cs!collections/featured-cnx-books')
  shave = require('shave')
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

    shaveBookDescriptions: () ->
      shave('.book .description', 60)
      $('.book:not(:has(.description .js-shave)) .read-more').hide()

    readMore: (event) ->
      read_more = $(this).parent()
      book = read_more.parent()
      book.find('.description .js-shave-char').hide()
      book.find('.description .js-shave').show('highlight')
      $(this).hide()
      read_more.find('.less').show()
      event.preventDefault()

    readLess: (event) ->
      read_more = $(this).parent()
      book = read_more.parent()
      book.find('.description .js-shave-char').show('highlight')
      book.find('.description .js-shave').hide('highlight')
      $(this).hide()
      read_more.find('.more').show()
      event.preventDefault()

    onBeforeRender: () ->
      @collection.reset(featuredOpenStaxBooks.models)
      @collection.add(featuredCNXBooks.models)

    onAfterRender: () ->
      $('.read-more .more').on('click', @readMore)
      $('.read-more .less').on('click', @readLess)
      setTimeout(@shaveBookDescriptions, 0)

    onBeforeClose: () ->
      $(window).off('resize.featuredBooks')
