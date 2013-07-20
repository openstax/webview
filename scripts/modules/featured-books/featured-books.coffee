define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/base'
  'cs!collections/library'
  'hbs!./featured-books-template'
  'less!./featured-books'
], ($, _, Backbone, BaseView, library, template) ->

    return class FeaturedBooksView extends BaseView
      initialize: () ->
        @listenTo(library, 'reset', @render)

      render: () ->
        @template = template({books: library.toJSON()})
        @$el.html(@template)
        @startCarousel()

        return @

      startCarousel: () ->
        nextFeatured = () =>
          $books = @$el.find('.book')
          $first = $books.first()
          $second = $books.eq(1)

          hoffset = $first.offset().left - $second.offset().left
          voffset = $first.offset().top - $second.offset().top

          $first.animate {marginLeft: hoffset, marginTop: voffset}, 1000, () ->
            $first.insertAfter($books.last()).css({marginLeft: 0, marginTop: 0})

        if @_carousel then clearInterval(@_carousel)
        @_carousel = setInterval(nextFeatured, 10000)
