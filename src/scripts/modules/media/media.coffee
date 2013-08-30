define [
  'cs!models/content'
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
], (Content, BaseView, HeaderView, FooterView, MediaEndorsedView, MediaTitleView, MediaTabsView,
    MediaNavView, MediaHeaderView, MediaBodyView, MediaFooterView, template) ->

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
