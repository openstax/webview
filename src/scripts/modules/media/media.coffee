define (require) ->
  feature = require('cs!helpers/feature')
  mediaWithAuthoring = require('cs!./media-authoring')
  media = require('cs!./media-base')
  return feature(media, 'authoring': mediaWithAuthoring)
