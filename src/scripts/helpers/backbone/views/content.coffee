define (require) ->
  feature = require('cs!helpers/feature')
  editable = require('cs!helpers/backbone/views/editable')
  mediaComponent = require('cs!helpers/backbone/views/media-component')
  return feature('authoring', editable, mediaComponent)