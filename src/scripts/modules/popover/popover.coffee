define [
  'jquery'
  'underscore'
  'cs!helpers/backbone/views/base'
  'less!./popover'
  'bootstrapPopover'
], ($, _, BaseView) ->

  # Close popovers when clicking on the document
  $(document).click (e) ->
    $el = $(document.elementFromPoint(e.clientX, e.clientY))

    # Don't clear the popover if clicking in it
    if not $el.parents().hasClass('popover')
      PopoverView.hidePopovers()

  return class PopoverView extends BaseView
    @popovers: []

    initialize: (params) ->
      if typeof params isnt 'object' or not params.owner
        throw new Error('Tried to initialize PopoverView, but no \'owner\' was defined.')

      @options = params.options
      @events = params.events
      @setElement(params.owner)

      @$el.popover(@options)
      @constructor.popovers.push(@$el)

      # Stop propogation of 'click' events so popover doesn't get auto-closed
      @$el.on 'click', (e) -> e.stopPropagation()

      # Attach event handler to close open popovers on show
      @$el.on 'show.bs.popover', (e) =>
        @constructor.hidePopovers() # Close open popovers

      # Attach event handler to correctly position the popover after it's added to the DOM
      @$el.on 'shown.bs.popover', (e) =>
        $popover = @$el.siblings('.popover')

        # Adjust popover positioning
        if @options?.placement is 'bottom'
          # HACK: Position popover at far left to prevent whitespace wrapping from affecting popover width
          $popover.find('.arrow').css({top: '-7px', left: '100%'})
          $popover.css('left', 0)
          $popover.css('left', @$el.offset().left + @$el.width() - $popover.width() + 'px')

      # Attach custom event handlers to popover
      @$el.on('show.bs.popover', @events?.show)
      @$el.on('shown.bs.popover', @events?.shown)
      @$el.on('hide.bs.popover', @events?.hide)
      @$el.on('hidden.bs.popover', @events?.hidden)

      # Show the popover immediately if option 'show' is true
      if params.show then @show()

    render: () ->
      return @show()

    show: () ->
      @$el.popover('show')
      return @

    hide: () ->
      @$el.popover('hide')
      return @

    toggle: () ->
      @$el.popover('toggle')
      return @

    destroy: () ->
      @close()
      return @

    @hidePopovers: () ->
      _.each @popovers, ($popover) ->
        $popover.popover('hide')

    @removePopover: ($el) ->
      @popovers = _.reject @popovers, ($popover) ->
        return _.isEqual($el, $popover)

    close: () ->
      @constructor.removePopover(@$el)
      @$el.popover('destroy')
      super()
