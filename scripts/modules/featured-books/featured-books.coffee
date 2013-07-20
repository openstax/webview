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
          $third = $books.eq(2)

          hoffset = $first.offset().left - $second.offset().left
          voffset = $first.offset().top - $second.offset().top

          $third.css
            display: 'block'
            position: 'absolute'
            marginLeft: hoffset*-2 + 'px'

          $first.animate {marginLeft: hoffset, marginTop: voffset, opacity: 0}, 1000, () ->
            $first.insertAfter($books.last()).css
              display: 'none'
              marginLeft: 0
              marginTop: 0
              opacity: 1

          $third.animate {marginLeft: hoffset*-1+'px'}, 1000, () ->
            $third.css({position: 'static', marginLeft: 0})

        if @_carousel then clearInterval(@_carousel)
        @_carousel = setInterval(nextFeatured, 3000)
