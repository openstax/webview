define (require) ->
  _ = require('underscore')
  $ = require('jquery')
  require('jqueryui')
  Backbone = require('backbone')
  BaseView = require('cs!helpers/backbone/views/base')
  featuredOpenStaxBooks = require('cs!collections/featured-openstax-books')
  featuredCNXBooks = require('cs!collections/featured-cnx-books')
  imagesLoaded = require('imagesloaded')
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
      @debouncedShaveBookDescriptionsAfterImagesLoaded = \
        _.debounce(@shaveBookDescriptionsAfterImagesLoaded, 300)

    readMore: (event) ->
      read_more = $(this).parent()
      book = read_more.parent()
      book.find('.description').css('height', 'auto')
      $(this).hide()
      read_more.find('.less').show()
      event.preventDefault()

    readLess: (event) ->
      read_more = $(this).parent()
      book = read_more.parent()
      book.find('.description').css('height', '60px')
      $(this).hide()
      read_more.find('.more').show()
      event.preventDefault()

    onBeforeRender: () ->
      @collection.reset(featuredOpenStaxBooks.models)
      @collection.add(featuredCNXBooks.models)

    onAfterRender: () ->
      $('.show-more-less .more').on('click', @readMore)
      $('.show-more-less .less').on('click', @readLess)
      $(window).resize(@debouncedShaveBookDescriptionsAfterImagesLoaded)

    onBeforeClose: () ->
      $(window).off('resize', @debouncedShaveBookDescriptionsAfterImagesLoaded)
