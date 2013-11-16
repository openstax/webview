define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!helpers/backbone/views/attached/tooltip/tooltip-template')
  require('less!helpers/backbone/views/attached/tooltip/tooltip')

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

    onShow: () ->
      switch @trigger
        when 'click'
          @$owner.on "click.#{@type}.#{@cid}", () => @toggle()
        when 'hover'
          @$owner.on "mouseenter.#{@type}.#{@cid}", () => @show()
          @$owner.on "mouseleave.#{@type}.#{@cid}", () => @hide()

    show: () ->
      @reposition()
      @$el.children(".#{@type}").show().addClass('in')

    hide: () ->
      @reposition()
      @$el.children(".#{@type}").hide().removeClass('in')

    toggle: () ->
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
      @$owner.off "click.#{@type}.#{@cid}"
      @$owner.off "mouseenter.#{@type}.#{@cid}"
      @$owner.off "mouseleave.#{@type}.#{@cid}"
