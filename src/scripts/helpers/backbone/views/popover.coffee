define [
  'cs!helpers/backbone/views/base'
  'cs!helpers/handlers/popover-handler'
], (BaseView, popoverHandler) ->

  return class PopoverView extends BaseView
    initialize: (options) ->
      @popover ?= {}
      _.extend(@popover, options)

      if not @popover
        throw new Error('\'popover\' not defined on object inheriting PopoverView nor passed to constructor')

      if not @popover.owner
        throw new Error('\'popover.owner\' not defined on object inheriting PopoverView nor passed to constructor')

      @popover = popoverHandler.createPopover(@popover)

    render: () -> return @

    close: () ->
      @popover.close()
      @popover = null
      super()
