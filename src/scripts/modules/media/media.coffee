define (require) ->
  Content = require('cs!models/content')
  BaseView = require('cs!helpers/backbone/views/base')
  HeaderView = require('cs!modules/header/header')
  FooterView = require('cs!modules/footer/footer')
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
    template: template()

    initialize: (options) ->
      super()

      if not options or not options.uuid
        throw new Error('A media view must be instantiated with the uuid of the media to display')

      @uuid = options.uuid
      @content = new Content({id: @uuid})

    regions:
      media: '.media'

    render: () ->
      super()

      @regions.media.append(new MediaEndorsedView({content: @content}))
      @regions.media.append(new MediaTitleView({content: @content}))
      @regions.media.append(new MediaTabsView({content: @content}))
      @regions.media.append(new MediaNavView({content: @content}))
      @regions.media.append(new MediaHeaderView({content: @content}))
      @regions.media.append(new MediaBodyView({content: @content}))
      @regions.media.append(new MediaFooterView({content: @content}))
      @regions.media.append(new MediaNavView({content: @content, hideProgress: true}))

      return @
