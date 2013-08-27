define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  BaseView = require('cs!helpers/backbone/views/base')
  MailPopoverView = require('cs!./popovers/mail/mail')
  template = require('hbs!./title-template')
  require('less!./title')

  return class MediaTitleView extends BaseView
    template: () ->
      content = @model.toJSON()
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

    initialize: () ->
      super()

      @listenTo(@model, 'all', @render)

    render: () ->
      super()

      $share = @$el.find('.share')
      @attachPopover new MailPopoverView({owner: $share.find('.mail')})
