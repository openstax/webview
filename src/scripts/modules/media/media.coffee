define (require) ->
  Content = require('cs!models/content')
  BaseView = require('cs!helpers/backbone/views/base')
  MediaEndorsedView = require('cs!./endorsed/endorsed')
  MediaTitleView = require('cs!./title/title')
  MediaTabsView = require('cs!./tabs/tabs')
  MediaNavView = require('cs!./nav/nav')
  MediaHeaderView = require('cs!./header/header')
  MediaBodyView = require('cs!./body/body')
  MediaFooterView = require('cs!./footer/footer')
  template = require('hbs!./media-template')
  require('less!./media')

  return class MediaView extends BaseView
    template: template

    initialize: (options) ->
      super()

      if not options or not options.uuid
        throw new Error('A media view must be instantiated with the uuid of the media to display')

      @uuid = options.uuid
      @model = new Content({id: @uuid, page: options.page})

    regions:
      media: '.media'

    onRender: () ->
      @regions.media.append(new MediaEndorsedView({model: @model}))
      @regions.media.append(new MediaTitleView({model: @model}))
      @regions.media.append(new MediaTabsView({model: @model}))
      @regions.media.append(new MediaNavView({model: @model}))
      @regions.media.append(new MediaHeaderView({model: @model}))
      @regions.media.append(new MediaBodyView({model: @model}))
      @regions.media.append(new MediaFooterView({model: @model}))
      @regions.media.append(new MediaNavView({model: @model, hideProgress: true}))
