define (require) ->
  $ = require('jquery')
  InfoBlockView = require('cs!modules/inherits/info-block/info-block')
  featuredBooks = require('cs!collections/featured-books')
  template = require('hbs!./featured-books-template')
  require('less!./featured-books')

  return class FeaturedBooksView extends InfoBlockView
    template: template
    collection: featuredBooks
    title: 'Featured Books'

    initialize: () ->
      super()
      @listenTo(@collection, 'reset', @render)

    onRender: () ->
      @$el.find('.more').hide()
      @$el.find('.book').show()
      @_expanded = true

    onBeforeClose: () ->
      $(window).off('resize.featuredBooks')
