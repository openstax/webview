define (require) ->
  (ContentViewBase, settings) ->
    _ = require('underscore')
    coachMixin = require('cs!helpers/backbone/views/coach-mixin')

    return class MediaHeaderView extends ContentViewBase.extend(coachMixin)
      templateHelpers: () ->
        coach = @getCoachEl(@mediaBody)
        isCoach = @isCoach()

        coachHelpers = {
          jumpToCC: isCoach and coach instanceof Node and document.body.contains(coach)
          conceptCoach: isCoach
        }

        return _.extend(coachHelpers, super())

      events: _.extend({}, ContentViewBase.prototype.events, {
        'click .jump-to-cc > .btn': 'jumpToConceptCoach'
      })

      initialize: (options) ->
        super()
        @mediaBody = options.mediaBody
        @listenTo(@mediaBody, 'change:coachMounted', @render)

      onRender: ->
        if not @model.asPage()?.get('active') then return
        super() unless @isCoach()
