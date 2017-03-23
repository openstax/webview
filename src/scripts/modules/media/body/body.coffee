define (require) ->
  feature = require('cs!helpers/feature')
  bodyWithAuthoring = require('cs!./body-authoring')
  bodyWithCoach = require('cs!./body-coach')
  body = require('cs!./body-base')
  return feature(body, {authoring: bodyWithAuthoring, conceptCoach: bodyWithCoach})
