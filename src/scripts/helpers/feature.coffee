define (require) ->
  settings = require('settings')

  return (featureName, enabledModule, disabledModule) ->
    module = if settings.hasFeature(featureName) then enabledModule else disabledModule
    return module
