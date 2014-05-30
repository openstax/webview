define (require) ->
  _ = require('underscore')
  Backbone = require('backbone')
  session = require('cs!session')
  router = require('cs!router')
  EditableView = require('cs!helpers/backbone/views/editable')
  #MailPopoverView = require('cs!./popovers/mail/mail')
  template = require('hbs!./title-template')
  require('less!./title')

  return class MediaTitleView extends EditableView
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

      return {
        share: share
        encodedTitle: encodeURI(title)
        derivable: not @model.isDraft()
        authenticated: session.get('id')
      }

    editable:
      '.media-title > .title > h1':
        value: 'title'
        type: 'textinput'

    events:
      'click .derive .btn': 'derive'

    initialize: () ->
      super()
      @listenTo(@model, 'change:loaded change:title', @render)
      @listenTo(router, 'navigate', @render)

    derive: () ->
      options =
        success: (model) =>
          router.navigate("/contents/#{model.id}@#{model.version}", {trigger: true})
      
      # Derive a copy of the book and then navigate to it
      @model.derive(options)
