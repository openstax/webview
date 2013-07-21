define [
  'jquery'
  'underscore'
  'backbone'
  'cs!modules/info-block/info-block'
  'cs!collections/library'
  'hbs!./featured-books-template'
  'less!./featured-books'
], ($, _, Backbone, InfoBlockView, library, template) ->

    return class FeaturedBooksView extends InfoBlockView
      initialize: () ->
        super()
        @listenTo(library, 'reset', @render)

      render: () ->
        @template = template({books: library.toJSON()})
        @$el.html(@template)
        @startCarousel()

        return @

      startCarousel: () ->
        # Animate the carousel to show the next featured book
        nextFeatured = () =>
          $books = @$el.find('.book')
          $first = $books.first()
          $second = $books.eq(1)
          $third = $books.eq(2)

          hoffset = $first.offset().left - $second.offset().left
          voffset = $first.offset().top - $second.offset().top

          $third.css({display: 'block', position: 'absolute', marginLeft: hoffset*-2 + 'px'})

          $first.animate {marginLeft: hoffset, marginTop: voffset, opacity: 0}, 1000, () ->
            $first.insertAfter($books.last()).removeAttr('style')

          $third.animate {marginLeft: hoffset*-1+'px'}, 1000, () ->
            $third.removeAttr('style')

        # Start the carousel
        if @_carousel then clearInterval(@_carousel)
        @_carousel = setInterval(nextFeatured, 3000)
