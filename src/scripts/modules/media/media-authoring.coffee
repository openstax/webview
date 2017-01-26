define (require) ->
  _ = require('underscore')
  MediaView = require('cs!./media-base')

  return class MediaViewWithAuthoring extends MediaView
    regions: _.extend({}, MediaView.prototype.regions, {
      editbar: '.editbar'
    })

    events: _.extend({}, MediaView.prototype.events, {
      'keydown .media-title > .title input': 'checkKeySequence'
      'keyup .media-title > .title input': 'resetKeySequence'
    })

    initialize: (options) ->
      super(options)
      @listenTo(@model, 'change:editable', @toggleEditor)

    onBeforeClose: () ->
      if @model.get('editable')
        @model.set('editable', false, {silent: true})
        @closeEditor()
      super()
