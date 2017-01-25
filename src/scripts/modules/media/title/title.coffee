define (require) ->
  _ = require('underscore')
  Backbone = require('backbone')
  session = require('cs!session')
  router = require('cs!router')
  ContentView = require('cs!helpers/backbone/views/content')
  template = require('hbs!./title-template')
  settings = require('settings')
  socialMedia = require('cs!helpers/socialmedia.coffee')
  linksHelper = require('cs!helpers/links.coffee')
  require('less!./title')

  return class MediaTitleView extends ContentView
    template: template
    templateHelpers: () ->
      title = @model.get('title')
      locationOrigin = linksHelper.locationOrigin()

      return {
        share: socialMedia.socialMediaInfo(@parent.summary(),title,locationOrigin)
        encodedTitle: encodeURI(title)
        derivable: not @model.isDraft()
        authenticated: session.get('id')
        isBook: @model.isBook()
        editable: @model.canEdit()
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

    onRender: ->
      @trigger('render')

    edit: () ->
      data = JSON.stringify({id: @model.get('id')})
      options =
        success: (model) ->
          router.navigate("/contents/#{model.id}@draft", {trigger: true})

      @model.editOrDeriveContent(options, data)

    derive: () ->
      data = JSON.stringify({derivedFrom: @model.getVersionedId()})
      options =
        success: (model) ->
          router.navigate("/contents/#{model.id}@#{model.version}", {trigger: true})

      # Derive a copy of the book and then navigate to it
      @model.editOrDeriveContent(options, data)
