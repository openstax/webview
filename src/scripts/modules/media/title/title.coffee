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
        view.popovers.push new PopoverView
          owner: $(this)
          options:
            html: true
            placement: 'bottom'
            content: '<p>test content2</p>'

    close: () ->
      @popovers.pop().destroy() while @popovers.length
      super()
