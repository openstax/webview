define [
  'underscore'
  'cs!helpers/backbone/views/base'
  'cs!helpers/handlers/popover-handler'
], (_, BaseView, popoverHandler) ->

  return class PopoverView extends BaseView
    initialize: (options) ->
      @_popover = _.extend({}, @popover or {}, options)
      delete @popover

      if not @_popover
        throw new Error('\'popover\' not defined on object inheriting PopoverView nor passed to constructor')

      if not @_popover.owner
        throw new Error('\'popover.owner\' not defined on object inheriting PopoverView nor passed to constructor')

      @_popover = popoverHandler.createPopover(@_popover)
      console.log @

    render: () -> return @

    close: () ->
      @_popover.close()
      @_popover = null
      super()
