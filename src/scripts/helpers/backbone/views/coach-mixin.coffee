
define (require) ->
  settings = require('settings')

  getCoachRegion: (mediaBody) ->
    (mediaBody or @).regions?.coach?.$el

  getCoachEl: (mediaBody) ->
    @getCoachRegion(mediaBody)?.get(0)

  hasCoach: (mediaBody) ->
    @getCoachRegion(mediaBody)?

  getCoach: ->
    moduleUUID = @model.getUuid()?.split('?')[0]
    settings.conceptCoach?.uuids?[moduleUUID]

  isCoach: ->
    @getCoach()?
