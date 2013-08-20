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

  return class Popover extends BaseView
    @popovers: []

    initialize: (params) ->
      if typeof params isnt 'object' or not params.owner
        throw new Error('Tried to initialize Popover, but no \'owner\' was defined.')

      @events = params.events
      @$owner = params.owner

      @$owner.popover(params.options)
      @constructor.popovers.push(@$owner)

      # Stop propogation of 'click' events so popover doesn't get auto-closed
      @$owner.click (e) => e.stopPropagation()

      # Attach event handler to close open popovers on show
      @$owner.on 'show.bs.popover', (e) =>
        @constructor.hidePopovers() # Close open popovers

      @$owner.one 'shown.bs.popover', (e) =>
        @setElement @$owner.data('bs.popover').$tip
        @delegateEvents(@events) # Attach custom event handlers to popover

      @$owner.on 'shown.bs.popover', (e) =>
        # Adjust popover positioning
        if params.options?.placement is 'bottom'
          @$el.find('.arrow').css({top: '-7px', left: '100%'})
          @$el.css
            'left': 'auto'
            'right': document.body.clientWidth - (@$owner.offset().left + @$owner.outerWidth())

    render: () -> return @ # noop

    @hidePopovers: () ->
      _.each @popovers, ($owner) ->
        popover = $owner.data('bs.popover')
        if popover.hoverState is 'in'
          $owner.popover('hide')
          popover.$tip.detach() # HACK: Bootstrap is not properly detaching the popover dom element

    @removePopover: ($el) ->
      @popovers = _.reject @popovers, ($popover) ->
        return _.isEqual($el, $popover)

    close: () ->
      @constructor.removePopover(@$owner)
      @$owner.popover('destroy')
      super()
