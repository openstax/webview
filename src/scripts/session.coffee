define (require) ->
  feature = require('cs!helpers/feature')
  authoring = require('cs!session-authoring')
  stub = require('cs!session-stub')
  return feature(stub, authoring: authoring)
