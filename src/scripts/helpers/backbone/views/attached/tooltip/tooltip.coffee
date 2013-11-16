define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!helpers/backbone/views/attached/tooltip/tooltip-template')
  require('less!helpers/backbone/views/attached/tooltip/tooltip')

  # Close tooltips and popovers when clicking outside of them
  $(document).on 'click', ':not(a)', () ->
    $('.popover, .tooltip').hide().removeClass('in')

  return class Tooltip extends BaseView
    containerTemplate: template

    type: 'tooltip'
    trigger: 'hover'
    placement: 'top'

    _renderDom: (data) ->
      @$el?.html @containerTemplate
        title: @title
        placement: @placement
        content: @template?(data) or @template

    initialize: (options = {}) ->
      super()
      @$owner = $(options.owner)

    stopPropagation: (e) ->
      e.stopPropagation() if e.target.localName isnt 'a'

    onShow: () ->
      # Don't close due to clicks on this element
      @$el.on "click.#{@type}.#{@cid}", @stopPropagation

      switch @trigger
        when 'click'
          @$owner.on "click.#{@type}.#{@cid}", (e) => @toggle(e)
        when 'hover'
          @$owner.on "mouseenter.#{@type}.#{@cid}", (e) => @show(e)
          @$owner.on "mouseleave.#{@type}.#{@cid}", (e) => @hide(e)

    show: (e) ->
      @stopPropagation(e)
      @reposition()
      @$el.children(".#{@type}").show().addClass('in')

    hide: (e) ->
      @stopPropagation(e)
      @$el.children(".#{@type}").hide().removeClass('in')

    toggle: (e) ->
      @stopPropagation(e)
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

    onBeforeClose: () ->
      @$el.off "click.#{@type}.#{@cid}"
      @$owner.off "click.#{@type}.#{@cid}"
      @$owner.off "mouseenter.#{@type}.#{@cid}"
      @$owner.off "mouseleave.#{@type}.#{@cid}"
