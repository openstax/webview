define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!helpers/backbone/views/attached/tooltip/tooltip-template')
  require('less!helpers/backbone/views/attached/tooltip/tooltip')

  # Close tooltips and popovers when clicking outside of them
  # Ignore popover's with class .math-popover for Aloha
  $(document).on 'click', (e) ->
    $('.popover:not(.math-popover), .tooltip').hide().removeClass('in')

  return class Tooltip extends BaseView
    containerTemplate: template

    type: 'tooltip'
    trigger: 'hover'
    placement: 'top'

    renderDom: (data) ->
      @$el?.html @containerTemplate
        title: @title
        placement: @placement
        content: @getTemplate()

    initialize: (options = {}) ->
      super()
      @$owner = $(options.owner)

    onShow: () ->
      @removeEvents() # Remove event handlers in case they were previously added

      # Don't close due to clicks on this element
      @$el.on "click.#{@type}.#{@cid}", (e) ->
        # Allow download links to propagate up and be handled by loader.coffee
        if $(e.target).data('prop') isnt true
          e.stopPropagation()

      switch @trigger
        when 'click'
          @$owner.on "click.#{@type}.#{@cid}", (e) => @toggle(e)
        when 'hover'
          @$owner.on "mouseenter.#{@type}.#{@cid}", (e) => @show(e)
          @$owner.on "mouseleave.#{@type}.#{@cid}", (e) => @hide(e)

    show: (e) ->
      e.stopPropagation()
      @reposition()
      @$el.children(".#{@type}").show().addClass('in')

    hide: (e) ->
      e.stopPropagation()
      @$el.children(".#{@type}").hide().removeClass('in')

    toggle: (e) ->
      # Allow download links to propagate up and be handled by loader.coffee
      if $(e.target).data('prop') isnt true
        e.stopPropagation()
      @reposition()
      @$el.children(".#{@type}").toggle().toggleClass('in')

    reposition: () ->
      $container = @$el.children(".#{@type}")

      switch @placement
        when 'top'
          $container.css
            'top': Math.floor(@$owner.offset().top - @$el.children('.popover').outerHeight())
            'left': 'auto'
            'right': Math.floor($(document).outerWidth(true) - (@$owner.offset().left + @$owner.outerWidth()))
        when 'right'
          $container.css
            'top': Math.floor(@$owner.offset().top)
            'left': Math.floor(@$owner.offset().left + @$owner.outerWidth())
        when 'bottom'
          $container.css
            'top': Math.floor(@$owner.offset().top + @$owner.outerHeight())
            'left': 'auto'
            'right': Math.floor($(document).outerWidth(true) - (@$owner.offset().left + @$owner.outerWidth()))
        when 'left'
          $container.css
            'top': Math.floor(@$owner.offset().top)
            'left': 'auto'
            'right': Math.floor($(document).outerWidth(true) - @$owner.offset().left)

    removeEvents: () ->
      @$el.off "click.#{@type}.#{@cid}"
      @$owner.off "click.#{@type}.#{@cid}"
      @$owner.off "mouseenter.#{@type}.#{@cid}"
      @$owner.off "mouseleave.#{@type}.#{@cid}"

    onBeforeClose: () ->
      @removeEvents()
      delete @$owner
