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


    # Called when the 'More' link is clicked
    more: () ->
      @$el.find('.book').show()
      @_expanded = true

    # Called when the 'Less' link is clicked
    less: () ->
      @$el.find('.book').slice(2).removeAttr('style')
      @_expanded = false

    onBeforeClose: () ->
      $(window).off('resize.featuredBooks')
