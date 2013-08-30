# The PopoverView can be inherited or used directly to add a popover to another view.
#
# This class is a wrapper for `helpers/handlers/popover` that adds boilerplate
# code necessary to prevent memory leaks related to popovers.
#
# When creating a popover, use or inherit from this class, rather than creating a
# popover directly with `helpers/handlers/popover`.

define [
  'underscore'
  'cs!helpers/backbone/views/base'
  'cs!helpers/handlers/popover'
], (_, BaseView, Popover) ->

  return class PopoverView extends BaseView
    initialize: (options) ->
      @_popover = _.extend({}, @popover or {}, options)
      delete @popover

      if not @_popover
        throw new Error('\'popover\' not defined on object inheriting PopoverView nor passed to constructor')

      if not @_popover.owner
        throw new Error('\'popover.owner\' not defined on object inheriting PopoverView nor passed to constructor')

      @_popover = new Popover(@_popover)

    render: () -> return @

    close: () ->
      @_popover.close()
      @_popover = null
      super()
