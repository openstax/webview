define (require) ->
  _ = require('underscore')
  Backbone = require('backbone')
  BaseView = require('cs!helpers/backbone/views/base')
  MailPopoverView = require('cs!./popovers/mail/mail')
  template = require('hbs!./title-template')
  require('less!./title')

  return class MediaTitleView extends BaseView
    template: template
    templateHelpers: () ->
      title = @model.get('title')
      currentPage = @model.get('currentPage')
      if currentPage
        share =
          url: Backbone.history.fragment
          source: @model.get('source') or currentPage.get('source') or 'OpenStax College'
          summary: @model.get('summary') or currentPage.get('summary') or 'An OpenStax College book.'
          title: title or currentPage.get('title')
          image: @model.get('image') or currentPage.get('image') or "#{Backbone.history.location.host}/images/logo.png"

      # Encode all of the shared values for a URI
      _.each share, (value, key, list) ->
        list[key] = encodeURI(value)

      return {share: share, encodedTitle: encodeURI(title)}

    initialize: () ->
      super()
      @listenTo(@model, 'change:title change:authors change:id', @render) if @model

    onRender: () ->
      $share = @$el.find('.share')
      @attachPopover new MailPopoverView({owner: $share.find('.mail'), model: @model})
