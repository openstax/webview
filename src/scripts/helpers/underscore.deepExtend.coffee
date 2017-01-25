define (require) ->
  _ = require('underscore')
  underscoreDeepExtend = require('underscoreDeepExtend')
  _.mixin(deepExtend: underscoreDeepExtend(_))

  return _