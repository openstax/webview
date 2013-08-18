define [
  'jquery'
  'cs!helpers/backbone/views/base'
  'cs!./popovers/mail/mail'
  'hbs!./title-template'
  'less!./title'
], ($, BaseView, MailPopoverView, template) ->

  return class MediaTitleView extends BaseView
    initialize: (options) ->
      super()
      @template = template options.content.toJSON()

    render: () ->
      super()

      $share = @$el.find('.share')
      @attachPopover new MailPopoverView({owner: $share.find('.mail')})
