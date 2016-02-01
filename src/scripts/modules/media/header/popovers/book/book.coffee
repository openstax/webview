define (require) ->
  Popover = require('cs!popover')
  template = require('hbs!./book-template')
  require('less!./book')

  return class BookPopoverView extends Popover
    template: template
    templateHelpers:
      currentPage: () ->
        return @model.asPage()
      isIpad: navigator.userAgent.match(/iPad/i) != null
    events:
      'click [data-ipad="true"]': (e) ->
        window.location.href = e.target.href

    placement: 'bottom'

    initialize: () ->
      super(arguments...)
      @listenTo(@model, 'change:currentPage change:downloads change:currentPage.downloads', @render)
