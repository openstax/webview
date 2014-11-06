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

  session = session.get('id')

  return class MediaTitleView extends EditableView

    template: template

    templateHelpers: () ->
      title = @model.get('title')
      locationOrigin = linksHelper.locationOrigin()

      return {
        share: socialMedia.socialMediaInfo(@parent.summary(),title,locationOrigin)
        encodedTitle: encodeURI(title)
        derivable: not @model.isDraft()
        authenticated: session
        isBook: @model.isBook()
        editable: @canEdit(@model)

      }

    canEdit: (model) ->
      if not model.isDraft()
        url = "#{location.protocol}//#{settings.cnxarchive.host}/extras/#{model.getVersionedId()}"
        canPublish = []

        $.ajax
          type: 'GET'
          dataType: 'json'
          url: url
          async: false
          success: (data) ->
            canPublish.push(data.canPublish[0])

         i = 0
         while i < canPublish.length
           if canPublish[i] is session
             return true
           i++


    editable:
      '.media-title > .title > h1':
        value: 'title'
        type: 'textinput'

    events:
      'click .derive .btn': 'derive'
      'click .edit .btn' : 'edit'

    edit: () ->
      @model.set('editable', true)
      @editPublishedContent()
      @model.fetch() #Don't think this should be used here... AMW

    initialize: () ->
      super()
      @listenTo(@model, 'change:loaded change:title', @render)
      @listenTo(router, 'navigate', @render)

    editPublishedContent: () ->
      options =
        success: (model) ->
          router.navigate("/contents/#{model.id}@draft", {trigger: true})

      @model.editPublishedContent(options)

    derive: () ->
      options =
        success: (model) ->
          router.navigate("/contents/#{model.id}@#{model.version}", {trigger: true})

      # Derive a copy of the book and then navigate to it
      @model.derive(options)
