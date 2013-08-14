define [
  'jquery'
  'cs!helpers/backbone/views/base'
  'cs!modules/popover/popover'
  'hbs!./title-template'
  'less!./title'
], ($, BaseView, PopoverView, template) ->

  return class MediaTitleView extends BaseView
    popovers: []
    template: template()

    render: () ->
      super()

      view = this

      @$el.find('.share li').each () ->
        popover = new PopoverView
          owner: $(this)
          options:
            html: true
            placement: 'bottom'
            content: '<h1>test content2</h1>'

        view.popovers.push(popover)

    close: () ->
      @popovers.pop().destroy() while @popovers.length
      super()
