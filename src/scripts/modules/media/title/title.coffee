define [
  'underscore'
  'jquery'
  'cs!helpers/backbone/views/base'
  'cs!./popovers/mail/mail'
  'hbs!./title-template'
  'less!./title'
], (_, $, BaseView, MailPopoverView, template) ->

  return class MediaTitleView extends BaseView
    template: () ->
      content = @content.toJSON()
      content.share =
        url: window.location.href.split('#')[0] # Get the current URL without a hash string
        source: content.source or content.currentPage.source or 'OpenStax College'
        summary: content.summary or content.currentPage.summary or 'An OpenStax College book.'
        title: content.title or content.currentPage.title
        image: content.image or content.currentPage.image or "#{window.location.host}/images/logo.png"

      # Encode all of the shared values for a URI
      _.each content.share, (value, key, list) ->
        list[key] = encodeURI(value)

      return template content

    initialize: (options) ->
      super()
      @content = options.content

      @listenTo(@content, 'all', @render)

    render: () ->
      super()

      $share = @$el.find('.share')
      @attachPopover new MailPopoverView({owner: $share.find('.mail')})
