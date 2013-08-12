define [
  'cs!helpers/backbone/views/base'
  'cs!modules/header/header'
  'cs!modules/footer/footer'
  'cs!./endorsed/endorsed'
  'cs!./title/title'
  'cs!./tabs/tabs'
  'cs!./nav/nav'
  'cs!./header/header'
  'cs!./body/body'
  'cs!./footer/footer'
  'hbs!./media-template'
  'less!./media'
], (BaseView, HeaderView, FooterView, MediaEndorsedView, MediaTitleView, MediaTabsView,
    MediaNavView, MediaHeaderView, MediaBodyView, MediaFooterView, template) ->

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

      @regions.media.append(new MediaEndorsedView({uuid: @uuid}))
      @regions.media.append(new MediaTitleView({uuid: @uuid}))
      @regions.media.append(new MediaTabsView({uuid: @uuid}))
      @regions.media.append(new MediaNavView({uuid: @uuid}))
      @regions.media.append(new MediaHeaderView({uuid: @uuid}))
      @regions.media.append(new MediaBodyView({uuid: @uuid}))
      @regions.media.append(new MediaFooterView({uuid: @uuid}))
      @regions.media.append(new MediaNavView({uuid: @uuid}))

      return @
