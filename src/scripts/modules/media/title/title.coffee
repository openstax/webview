define [
  'jquery'
  'cs!helpers/backbone/views/base'
  'cs!./popovers/mail/mail'
  'hbs!./title-template'
  'less!./title'
], ($, BaseView, MailPopoverView, template) ->

  return class MediaTitleView extends BaseView
    popovers: []
    template: template()

    render: () ->
      super()
      
      $share = @$el.find('.share')

      @popovers.push new MailPopoverView({owner: $share.find('.mail')})

    close: () ->
      @popovers.pop().close() while @popovers.length
      super()
