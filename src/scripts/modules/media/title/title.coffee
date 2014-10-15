define (require) ->
  _ = require('underscore')
  Backbone = require('backbone')
  session = require('cs!session')
  router = require('cs!router')
  EditableView = require('cs!helpers/backbone/views/editable')
  #MailPopoverView = require('cs!./popovers/mail/mail')
  template = require('hbs!./title-template')
  settings = require('settings')
  socialMedia = require('cs!helpers/socialmedia.coffee')
  linksHelper = require('cs!helpers/links.coffee')
  require('less!./title')

  return class MediaTitleView extends EditableView
    mediaType: 'book'

    template: template
    title:() -> @model.get('title')

    templateHelpers: () ->
      title = @title()
      location.origin = linksHelper.locationOrigin()

      return {
        share: socialMedia.socialMediaInfo(@parent.summary(), @title())
        encodedTitle: encodeURI(title)
        derivable: not @model.isDraft()
        authenticated: session.get('id')
        isBook: @model.isBook()
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
        success: (model) ->
          router.navigate("/contents/#{model.id}@#{model.version}", {trigger: true})

      # Derive a copy of the book and then navigate to it
      @model.derive(options)
