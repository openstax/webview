define (require) ->
  feature = require('cs!helpers/feature')
  bodyWithAuthoring = require('cs!./body-authoring')
  body = require('cs!./body-base')
  return feature(body, authoring: bodyWithAuthoring)
