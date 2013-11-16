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
      @$owner.on "#{@trigger}.#{@type}", () => @toggle()

    toggle: () ->
      @reposition()
      @$el.children('.popover').toggle()

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
      @$owner.off "#{@trigger}.#{@type}"
