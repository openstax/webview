define [
  'jquery'
  'underscore'
  'backbone'
  'cs!helpers/backbone/views/base'
  'cs!modules/header/header'
  'cs!modules/footer/footer'
  'cs!modules/find-content/find-content'
  'cs!./endorsed/endorsed'
  'cs!./title/title'
  'cs!./nav/nav'
  'cs!./header/header'
  'cs!./body/body'
  'cs!./footer/footer'
  'hbs!./media-template'
  'less!./media'
], ($, _, Backbone, BaseView, HeaderView, FooterView, FindContentView, MediaEndorsedView,
    MediaTitleView, MediaNavView, MediaHeaderView, MediaBodyView, MediaFooterView, template) ->

  return class MediaView extends BaseView
    template: template()

    initialize: (options) ->
      super()

      if not options or not options.uuid
        throw new Error('A media view must be instantiated with the uuid of the media to display')

      @uuid = options.uuid

    regions:
      media: '.media'

    render: () ->
      super()

      @regions.media.append(new FindContentView())
      @regions.media.append(new MediaEndorsedView({uuid: @uuid}))
      @regions.media.append(new MediaTitleView({uuid: @uuid}))
      @regions.media.append(new MediaNavView({uuid: @uuid}))
      @regions.media.append(new MediaHeaderView({uuid: @uuid}))
      @regions.media.append(new MediaBodyView({uuid: @uuid}))
      @regions.media.append(new MediaFooterView({uuid: @uuid}))
      @regions.media.append(new MediaNavView({uuid: @uuid}))

      return @
