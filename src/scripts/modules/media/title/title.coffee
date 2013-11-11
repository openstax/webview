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

      # Set information used for social media links
      share =
        url: window.location.href
        source: 'Connexions'
        summary: @model.get('abstract') or 'An OpenStax College book.'
        title: title or 'Untitled'
        image: @model.get('image') or "#{Backbone.history.location.origin}/images/logo.png"

      # Encode all of the shared values for a URI
      _.each share, (value, key, list) ->
        list[key] = encodeURI(value)

      return {share: share, encodedTitle: encodeURI(title)}

    initialize: () ->
      super()
      @listenTo(@model, 'change:title', @render)
      @listenTo(router, 'navigate', @render)

    #onRender: () ->
    #  $share = @$el.find('.share')
    #  @attachPopover new MailPopoverView({owner: $share.find('.mail'), model: @model})
