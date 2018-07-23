define (require) ->
  _ = require('underscore')
  $ = require('jquery')
  require('jqueryui')
  Backbone = require('backbone')
  BaseView = require('cs!helpers/backbone/views/base')
  featuredOpenStaxBooks = require('cs!collections/featured-openstax-books')
  featuredCNXBooks = require('cs!collections/featured-cnx-books')
  imagesLoaded = require('imagesloaded')
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
      @debouncedShaveBookDescriptionsAfterImagesLoaded = \
        _.debounce(@shaveBookDescriptionsAfterImagesLoaded, 300)

    shaveBookDescriptions: () ->
      shave('.book .description', 60)
      $('.book:has(.description .js-shave) .show-more-less').show()
      toggled_descriptions = $(
        '.book:has(.description .js-shave):has(.show-more-less .less:visible) .description'
      )
      toggled_descriptions.find('.js-shave-char').hide()
      toggled_descriptions.find('.js-shave').show()

    shaveBookDescriptionsAfterImagesLoaded: () =>
      imagesLoaded('.books', @shaveBookDescriptions)

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
      $('.show-more-less .more').on('click', @readMore)
      $('.show-more-less .less').on('click', @readLess)
      @shaveBookDescriptionsAfterImagesLoaded()
      $(window).resize(@debouncedShaveBookDescriptionsAfterImagesLoaded)

    onBeforeClose: () ->
      $(window).off('resize', @debouncedShaveBookDescriptionsAfterImagesLoaded)
