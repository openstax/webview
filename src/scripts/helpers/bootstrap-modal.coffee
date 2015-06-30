define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  require('bootstrapModal')

  return new class BootstrapModal
    _modal = $.fn.modal
    show = _modal.Constructor::show
    hide = _modal.Constructor::hide

    _.extend $.fn.modal.Constructor.prototype,
      show: () ->
        @$element.removeAttr('aria-hidden')
        return show.call(@)

      hide: () ->
        @$element.attr('aria-hidden', true)
        return hide.call(@)
