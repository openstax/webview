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
  $ = require('jquery')
  require('less!./title')

  return class MediaTitleView extends EditableView
    template: template
    templateHelpers: () ->
      title = @model.get('title')
      locationOrigin = linksHelper.locationOrigin()
      user = session.get('id')

      return {
        share: socialMedia.socialMediaInfo(@parent.summary(),title,locationOrigin)
        encodedTitle: encodeURI(title)
        derivable: not @model.isDraft()
        authenticated: user
        isBook: @model.isBook()
        editable: @model.canEdit(user)
      }

    editable:
      '.media-title > .title > h1':
        value: 'title'
        type: 'textinput'

    events:
      'click .derive .btn': 'derive'
      'click .edit .btn' : 'edit'

    initialize: () ->
      super()
      @listenTo(@model, 'change:loaded change:title change:canPublish', @render)
      @listenTo(router, 'navigate', @render)

    edit: () ->
      data = JSON.stringify({id: @model.get('id')})
      options =
        success: (model) ->
          router.navigate("/contents/#{model.id}@draft", {trigger: true})

      @model.editOrDeriveContent(options, data)

    derive: () ->
      data = JSON.stringify({derivedFrom: @model.get('id')})
      options =
        success: (model) ->
          router.navigate("/contents/#{model.id}@#{model.version}", {trigger: true})

      # Derive a copy of the book and then navigate to it
      @model.editOrDeriveContent(options, data)
