define [
  'jquery'
  'underscore'
  'backbone'
  'less!./popover'
  'bootstrapPopover'
], ($, _, Backbone) ->

  class PopoverView extends Backbone.View
    @popovers: []

    initialize: (params) ->
      if typeof params isnt 'object' or not params.owner
        throw new Error('Tried to initialize PopoverView, but no \'owner\' was defined.')

      @options = params.options
      @events = params.events

      @$parent = params.owner.popover(@options)
      @constructor.popovers.push(@$parent)

      # Stop propogation of 'click' events so popover doesn't get auto-closed
      @$parent.on 'click', (e) -> e.stopPropagation()

      # Attach event handler to close open popovers on show
      @$parent.on 'show.bs.popover', (e) =>
        @constructor.hidePopovers() # Close open popovers

      # Attach event handler to correctly position the popover after it's added to the DOM
      @$parent.on 'shown.bs.popover', (e) =>
        $popover = @$parent.siblings('.popover')

        # Adjust popover positioning
        if @options?.placement is 'bottom'
          $popover.find('.arrow').css({top: '-7px', left: '100%'})
          $popover.css('top', $popover.offset().top + 7 + 'px')
          # HACK: Position popover at far left to prevent whitespace wrapping from affecting popover width
          $popover.css('left', 0)
          $popover.css('left', @$parent.offset().left + @$parent.width() - $popover.width() + 'px')

      # Attach custom event handlers to popover
      if typeof @events is 'object'
        if @events.show then @$parent.on('show.bs.popover', @events.show)
        if @events.shown then @$parent.on('shown.bs.popover', @events.shown)
        if @events.hide then @$parent.on('hide.bs.popover', @events.hide)
        if @events.hidden then @$parent.on('hidden.bs.popover', @events.hidden)

      # Show the popover immediately if option 'show' is true
      if params.show then @show()

    render: () ->
      return @show()

    show: () ->
      @$parent.popover('show')
      return @

    hide: () ->
      @$parent.popover('hide')
      return @

    toggle: () ->
      @$parent.popover('toggle')
      return @

    destroy: () ->
      @close()
      return @

    @hidePopovers: () ->
      _.each @popovers, ($popover) ->
        $popover.popover('hide')

    @removePopover: ($parent) ->
      @popovers = _.reject @popovers, ($popover) ->
        return _.isEqual($parent, $popover)

    close: () ->
      @constructor.removePopover(@$parent)
      @$parent.off() # Remove event handlers from popover
      @$parent.popover('destroy')
      @$parent = null

  # Close popovers when clicking on the document
  $(document).click (e) ->
    $el = $(document.elementFromPoint(e.pageX, e.pageY))

    # Don't clear the popover if clicking in it
    if not $el.parents().hasClass('popover')
      PopoverView.hidePopovers()

  return PopoverView
