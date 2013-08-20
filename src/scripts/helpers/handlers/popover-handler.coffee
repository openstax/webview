define [
  'jquery'
  'underscore'
  'cs!helpers/backbone/views/base'
  'bootstrapPopover'
], ($, _, BaseView) ->

  # Close popovers when clicking on the document
  $(document).click (e) ->
    $el = $(document.elementFromPoint(e.clientX, e.clientY))

    # Don't clear the popover if clicking in it
    if not $el.parents().hasClass('popover')
      Popover.hidePopovers()

  class Popover extends BaseView
    @popovers: []

    initialize: (params) ->
      if typeof params isnt 'object' or not params.owner
        throw new Error('Tried to initialize Popover, but no \'owner\' was defined.')

      @events = params.events
      @$owner = params.owner

      @$owner.popover(params.options)
      @constructor.popovers.push(@$owner)

      # Stop propogation of 'click' events so popover doesn't get auto-closed
      @$owner.on 'click', (e) => e.stopPropagation()

      # Attach event handler to close open popovers on show
      @$owner.on 'show.bs.popover', (e) =>
        @constructor.hidePopovers() # Close open popovers

      @$owner.on 'shown.bs.popover', (e) =>
        @setElement @$owner.data('bs.popover').$tip

        # Adjust popover positioning
        if params.options?.placement is 'bottom'
          @$el.find('.arrow').css({top: '-7px', left: '100%'})
          @$el.css
            'left': 'auto'
            'right': document.body.clientWidth - (@$owner.offset().left + @$owner.outerWidth())

        # Attach custom event handlers to popover
        @delegateEvents(@events)

      # Detach event handlers from popover on hide
      @$owner.on 'hide.bs.popover', (e) =>
        @undelegateEvents()

      # Show the popover immediately if option 'show' is true
      if params.show then @show()

    render: () -> return @ # noop

    @hidePopovers: () ->
      _.each @popovers, ($owner) ->
        popover = $owner.data('bs.popover')
        if popover.hoverState is 'in'
          $owner.popover('hide')
          popover.$tip.hide() # HACK: Bootstrap is not properly hiding the popover dom element

    @removePopover: ($el) ->
      @popovers = _.reject @popovers, ($popover) ->
        return _.isEqual($el, $popover)

    close: () ->
      @constructor.removePopover(@$owner)
      @$owner.popover('destroy')
      super()

  return new class PopoverHandler
    createPopover: (popover) ->
      return new Popover(popover)
