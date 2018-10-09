define (require) ->
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

    readMore: (event) ->
      read_more = $(this).parent()
      book = read_more.parent()
      book.find('.description').addClass('extended')
      $(this).hide()
      read_more.find('.less').show()
      event.preventDefault()

    readLess: (event) ->
      read_more = $(this).parent()
      book = read_more.parent()
      book.find('.description').removeClass('extended')
      $(this).hide()
      read_more.find('.more').show()
      event.preventDefault()

    onBeforeRender: () ->
      @collection.reset(featuredOpenStaxBooks.models)
      @collection.add(featuredCNXBooks.models)

    onAfterRender: () ->
      $('.show-more-less .more').on('click', @readMore)
      $('.show-more-less .less').on('click', @readLess)
      $('.description').each (i, desc) ->
        $(desc).css('max-height', '100%')
        if $(desc).height() <= 60
          $(desc).parent().find('.show-more-less')[0].style.display = 'none'
          $(desc).removeClass('show-ellipsis')
        else
          $(desc).css('max-height', '')
