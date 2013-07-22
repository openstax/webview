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
      title: 'Featured Books'

      initialize: () ->
        super()
        @listenTo(library, 'reset', @render)

      # @template must be evaluated prior to rendering
      beforeRender: () -> @template = template({books: library.toJSON()})
      afterRender: () -> @startCarousel()

      # Called when the 'More' link is clicked
      more: () ->
        @stopCarousel()
        @$el.find('.book').show()

      less: () ->
        @startCarousel()
        @$el.find('.book').removeAttr('style')

      stopCarousel: () ->
        @$el.find('.book').finish() # Immediately finish the animation
        clearInterval(@_carousel)
        @_carousel = null

      startCarousel: () ->
        # Animate the carousel to show the next featured book
        nextFeatured = () =>
          $container = @$el.find('.books')
          $books = $container.find('.book')
          $first = $books.first()
          $second = $books.eq(1)
          $third = $books.eq(2)

          hoffset = $first.offset().left - $second.offset().left
          voffset = $first.offset().top - $second.offset().top

          $container.css({'height': $container.height()+'px'})

          # Position the next book to scroll in
          $third.css({display: 'block'})
          if not voffset
            $third.css({position: 'absolute', marginLeft: hoffset*-2 + 'px', paddingLeft: '15px'})

          $first.animate {marginLeft: hoffset+'px', marginTop: voffset+'px'}, 1000, () ->
            $first.insertAfter($books.last()).removeAttr('style')
            $container.removeAttr('style')

          $second.animate {paddingLeft: 0, paddingRight: '15px'}, 1000, () ->
            $second.removeAttr('style')

          $third.animate {marginLeft: hoffset*-1+'px'}, 1000, () ->
            $third.removeAttr('style')

        # Start the carousel
        if @_carousel then clearInterval(@_carousel)
        @_carousel = setInterval(nextFeatured, 2000)
