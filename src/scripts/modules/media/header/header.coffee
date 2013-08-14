define [
  'jquery'
  'cs!helpers/backbone/views/base'
  'cs!modules/popover/popover'
  'hbs!./header-template'
  'less!./header'
], ($, BaseView, PopoverView, template) ->

  return class MediaHeaderView extends BaseView
    popovers: []
    template: template()

    render: () ->
      super()

      view = this

      @$el.find('.info .btn').each () ->
        popover = new PopoverView
          owner: $(this)
          options:
            html: true
            placement: 'bottom'
            content: '<h1>test content3</h1>'

        view.popovers.push(popover)

    close: () ->
      @popovers.pop().destroy() while @popovers.length
      super()
