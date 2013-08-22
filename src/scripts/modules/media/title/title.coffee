define [
  'jquery'
  'cs!helpers/backbone/views/base'
  'cs!./popovers/mail/mail'
  'hbs!./title-template'
  'less!./title'
], ($, BaseView, MailPopoverView, template) ->

  return class MediaTitleView extends BaseView
    template: template()

    render: () ->
      super()

      $share = @$el.find('.share')
      @attachPopover new MailPopoverView({owner: $share.find('.mail')})
