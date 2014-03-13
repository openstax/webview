define (require) ->
  _ = require('underscore')
  Backbone = require('backbone')
  router = require('cs!router')
  BaseView = require('cs!helpers/backbone/views/base')
  #MailPopoverView = require('cs!./popovers/mail/mail')
  template = require('hbs!./title-template')
  require('less!./title')

  return class MediaTitleView extends BaseView
    template: template
    templateHelpers: () ->
      title = @model.get('title')

      # Polyfill for location.origin since IE doesn't support it
      port = if location.port then ":#{location.port}" else ''
      location.origin = location.origin or "#{location.protocol}//#{location.hostname}#{port}"

      # Set information used for social media links
      share =
        url: window.location.href
        source: 'OpenStax CNX'
        summary: @model.get('abstract') or 'An OpenStax College book.'
        title: title or 'Untitled'
        image: @model.get('image') or "#{location.origin}/images/logo.png"

      # Encode all of the shared values for a URI
      _.each share, (value, key, list) ->
        list[key] = encodeURI(value)

      return {share: share, encodedTitle: encodeURI(title)}

    initialize: () ->
      super()
      @listenTo(@model, 'change:title change:loaded', @render)
      @listenTo(router, 'navigate', @render)

    #onRender: () ->
    #  $share = @$el.find('.share')
    #  @attachPopover new MailPopoverView({owner: $share.find('.mail'), model: @model})
