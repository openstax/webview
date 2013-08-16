define [
  'jquery'
  'cs!modules/inherits/info-block/info-block'
  'cs!collections/library'
  'hbs!./featured-books-template'
  'less!./featured-books'
], ($, InfoBlockView, library, template) ->

  return class FeaturedBooksView extends InfoBlockView
    title: 'Featured Books'

    initialize: () ->
      super()
      @listenTo(library, 'reset', @render)

      # Don't run any animations while the window is being resized
      @_resizer = () =>
        @stopCarousel({finish: true})
        @startCarousel()
      $(window).resize(@_resizer)

    events:
      'mouseenter .books': 'stopCarousel'
      'mouseleave .books': 'startCarousel'

    # @template must be evaluated prior to rendering
    beforeRender: () -> @template = template({books: library.toJSON()})
    afterRender: () -> @startCarousel()

    # Called when the 'More' link is clicked
    more: () ->
      @stopCarousel({finish: true})
      @$el.find('.book').show()
      @_expanded = true

    # Called when the 'Less' link is clicked
    less: () ->
      @startCarousel()
      @$el.find('.book').removeAttr('style')
      @_expanded = false

    stopCarousel: (options = {}) ->
      if options.finish then @$el.find('.book').finish() # Immediately finish the animation
      clearInterval(@_carousel)
      @_carousel = null

    startCarousel: () ->
      # Don't run the carousel while it's expanded
      if @_expanded then return

      # Animate the carousel to show the next featured book
      nextFeatured = () =>
        $container = @$el.find('.books')
        $books = $container.find('.book')
        $first = $books.first()
        $second = $books.eq(1)
        $third = $books.eq(2)

        hoffset = $first.offset().left - $second.offset().left
        voffset = $first.offset().top - $second.offset().top

        if voffset
          # Keep the container the same height during the transition
          $container.css({'height': $container.height()+'px'})

        # Position the next book to scroll in
        $third.css({display: 'block'})
        if not voffset
          $third.css({position: 'absolute', marginLeft: hoffset*-2 + 'px', paddingLeft: '15px'})

        # Slide the carousel
        $first.animate {marginLeft: hoffset+'px', marginTop: voffset+'px'}, 1000, () ->
          $first.insertAfter($books.last()).removeAttr('style')
          $container.removeAttr('style')

        # Adjust the second element to the first's style
        $second.animate {paddingLeft: 0, paddingRight: '15px'}, 1000, () ->
          $second.removeAttr('style')

        if not voffset
          # Adjust the third element to the second's style
          $third.animate {marginLeft: hoffset*-1+'px'}, 1000, () ->
            $third.removeAttr('style')

      # Start the carousel
      if @_carousel then clearInterval(@_carousel)
      @_carousel = setInterval(nextFeatured, 7000)

    close: () ->
      $(window).off('resize', @_resizer)
      @stopCarousel()
      super()
