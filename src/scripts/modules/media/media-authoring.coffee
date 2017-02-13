define (require) ->
  (MediaViewBase) ->
    _ = require('underscore')

    return class MediaViewWithAuthoring extends MediaViewBase
      regions: _.extend({}, MediaViewBase.prototype.regions, {
        editbar: '.editbar'
      })

      events: _.extend({}, MediaViewBase.prototype.events, {
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
